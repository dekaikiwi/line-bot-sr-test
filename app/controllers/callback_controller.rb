require 'line/bot'
require 'net/http'
require 'json'
require 'aws-sdk'

class CallbackController < ApplicationController

  skip_before_action :verify_authenticity_token

  Aws.config.update({
    region: 'us-east-1',
    credentials: Aws::Credentials.new(ENV['S3_TOKEN'], ENV['S3_TOKEN_SECRET'])
  })

  def index
  end

  def callback
    body = request.body.read

      signature = request.env['HTTP_X_LINE_SIGNATURE']
      unless client.validate_signature(body, signature)
        error 400 do 'Bad Request' end
      end

      events = client.parse_events_from(body)
      puts events.to_s
      events.each { |event|
        case event
        when Line::Bot::Event::Message

          user = JSON.parse(client.get_profile(event['source']['userId']).body)
          line_user = get_new_line_user(user['displayName'], user['userId'])

          puts "LINE USER IS: #{line_user.username}"

          case event.type
          when Line::Bot::Event::MessageType::Text
            storeMessage(event.message['text'], line_user, 'text')
            message = {
              type: 'text',
              text: "#{user['displayName']} says: #{event.message['text']}"
            }
            client.reply_message(event['replyToken'], message)
          when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
            message = {
              type: 'text',
              text: "You sent a video or photo!"
            }
            client.reply_message(event['replyToken'], message)
            response = client.get_message_content(event.message['id'])
            puts "== CONTENT =="
            tf = Tempfile.open("content")
            tf.binmode
            # puts response.body
            tf.write(response.body)
            puts tf.to_s
            public_url = uploadToS3(tf)

            postImageToShuttlerock(public_url)
          end
        end
      }
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def uploadToS3(file)
    bucket = Aws::S3::Bucket.new('scratch.shuttlerock.com')
    object = bucket.object("staff/jono/line_image_test/image-#{Time.now.to_i}.png")
    object.upload_file file, acl: "public-read"

    return object.public_url
  end

  def postImageToShuttlerock(image_url)
    uri = URI("https://api.shuttlerock.com/v2/jono/boards/line-test-board/entries.json")
    res = Net::HTTP.post_form(uri, name: 'Test Upload from Line', image_url: image_url, token: ENV["SHUTTLEROCK_API_KEY"])
    puts res.body
  end

  def get_new_line_user(name, mid)
    if !LineUser.exists?(mid: mid)
      @line_user = LineUser.new

      @line_user.username = name
      @line_user.mid = mid

      @line_user.save
    else
      @line_user = LineUser.find_by(mid: mid)
    end

    return @line_user
  end

  def storeMessage(message, user, type, isResponse = false)
    @message_item = Message.new

    @message_item.line_user_id = user.id
    @message_item.message = message
    @message_item.is_response = isResponse
    #@message_item.type = type

    @message_item.save
  end

  def send_message
    @line_user = LineUser.find(params[:id])
    storeMessage(params['message'], @line_user, params['type'], true)

    client.push_message(@line_user.mid, [{type: 'text', text: params['message']}] )
  end

end
