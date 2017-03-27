# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170327090736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "postgis"

  create_table "active_admin_comments", force: :cascade do |t|
    t.integer  "resource_id",               null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace",     limit: 255
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree
  end

  create_table "ads_campaigns", force: :cascade do |t|
    t.string   "slug",                 limit: 255,                         null: false
    t.string   "name",                 limit: 255,                         null: false
    t.text     "objective"
    t.string   "audience",             limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.decimal  "total_campaign_spend",             precision: 8, scale: 2
    t.integer  "site_id",                                                  null: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.index ["site_id", "name"], name: "index_ads_campaigns_on_site_id_and_name", unique: true, using: :btree
    t.index ["site_id"], name: "index_ads_campaigns_on_site_id", using: :btree
    t.index ["slug"], name: "index_ads_campaigns_on_slug", unique: true, using: :btree
  end

  create_table "ads_facebook_ad_creatives", force: :cascade do |t|
    t.integer  "board_item_id",                 null: false
    t.string   "link_title",       limit: 255
    t.string   "link_description", limit: 255
    t.string   "call_to_action",   limit: 255
    t.string   "target_url",       limit: 2048
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["board_item_id"], name: "index_ads_facebook_ad_creatives_on_board_item_id", unique: true, using: :btree
  end

  create_table "ads_facebook_ad_sets", force: :cascade do |t|
    t.string   "slug",                  limit: 255,                                    null: false
    t.string   "ad_set_id",             limit: 255,                                    null: false
    t.integer  "num_photos",                                       default: 2,         null: false
    t.text     "body_texts",                                       default: [],                     array: true
    t.text     "calls_to_action",                                  default: [],                     array: true
    t.text     "link_titles",                                      default: [],                     array: true
    t.string   "page_id",               limit: 255,                                    null: false
    t.string   "status",                limit: 255,                default: "pending", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "multi_share_end_card",                             default: true,      null: false
    t.string   "link",                  limit: 2048
    t.float    "max_frequency"
    t.integer  "max_number_of_ads"
    t.integer  "min_live_days"
    t.text     "link_descriptions",                                default: [],                     array: true
    t.decimal  "min_relevance",                      precision: 2, default: 0,         null: false
    t.boolean  "re_use_old_ads",                                   default: false,     null: false
    t.string   "content_type",          limit: 255,                default: "any",     null: false
    t.integer  "ads_campaign_id",                                                      null: false
    t.hstore   "options",                                          default: {},        null: false
    t.string   "name",                  limit: 255,                                    null: false
    t.string   "target_url",            limit: 2048,                                   null: false
    t.boolean  "use_ads_redirect_urls",                            default: false,     null: false
    t.string   "oauth_token_id",        limit: 255
    t.string   "ad_account_id",         limit: 255
    t.string   "ad_campaign_id",        limit: 255
    t.index ["ad_set_id"], name: "index_ads_facebook_ad_sets_on_ad_set_id", unique: true, where: "((status)::text <> 'archived'::text)", using: :btree
    t.index ["ads_campaign_id", "name"], name: "index_ads_facebook_ad_sets_on_ads_campaign_id_and_name", unique: true, using: :btree
    t.index ["ads_campaign_id"], name: "index_ads_facebook_ad_sets_on_ads_campaign_id", using: :btree
    t.index ["slug"], name: "index_ads_facebook_ad_sets_on_slug", unique: true, using: :btree
  end

  create_table "ads_facebook_ad_sets_board_items", id: false, force: :cascade do |t|
    t.integer "ads_facebook_ad_set_id", null: false
    t.integer "board_item_id",          null: false
    t.index ["ads_facebook_ad_set_id", "board_item_id"], name: "index_ads_facebook_ad_sets_board_items", unique: true, using: :btree
    t.index ["ads_facebook_ad_set_id"], name: "index_ads_facebook_ad_sets_board_items_on_ad_set_id", using: :btree
  end

  create_table "ads_facebook_ads", force: :cascade do |t|
    t.integer  "ad_set_id",                                           null: false
    t.string   "slug",                limit: 255,                     null: false
    t.integer  "num_photos",                                          null: false
    t.string   "body_text",           limit: 255,                     null: false
    t.string   "call_to_action",      limit: 255,                     null: false
    t.string   "link_title",          limit: 255,                     null: false
    t.string   "status",              limit: 255, default: "pending", null: false
    t.text     "board_item_ids",                  default: [],                     array: true
    t.string   "ad_id",               limit: 255
    t.float    "frequency",                       default: 0.0,       null: false
    t.integer  "relevance_score",                 default: 0,         null: false
    t.integer  "total_actions",                   default: 0,         null: false
    t.integer  "impressions",                     default: 0,         null: false
    t.float    "result_rate",                     default: 0.0,       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ads_redirect_url_id"
    t.text     "deleted_ad_ids",                  default: [],                     array: true
    t.string   "link_description",    limit: 255
    t.jsonb    "ad_set_settings",                 default: {},        null: false
    t.index ["ad_id"], name: "index_ads_facebook_ads_on_ad_id", unique: true, using: :btree
    t.index ["ad_set_id"], name: "index_ads_facebook_ads_on_ad_set_id", using: :btree
    t.index ["ads_redirect_url_id"], name: "index_ads_facebook_ads_on_ads_redirect_url_id", unique: true, using: :btree
    t.index ["slug"], name: "index_ads_facebook_ads_on_slug", unique: true, using: :btree
  end

  create_table "ads_redirect_urls", force: :cascade do |t|
    t.boolean  "used",                       default: false, null: false
    t.string   "url",           limit: 2048,                 null: false
    t.string   "slug",          limit: 255,                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resource_id",                                null: false
    t.string   "resource_type", limit: 255,                  null: false
    t.integer  "site_id",                                    null: false
    t.index ["resource_id", "resource_type", "url"], name: "index_ads_redirect_urls_on_resource_and_url", unique: true, using: :btree
    t.index ["resource_id", "resource_type"], name: "index_ads_redirect_urls_on_resource_id_and_resource_type", using: :btree
    t.index ["site_id"], name: "index_ads_redirect_urls_on_site_id", using: :btree
    t.index ["slug"], name: "index_ads_redirect_urls_on_slug", unique: true, using: :btree
  end

  create_table "app_invites", force: :cascade do |t|
    t.string   "slug",                            null: false
    t.integer  "site_id",                         null: false
    t.string   "email",                           null: false
    t.string   "invite_code",                     null: false
    t.string   "status",      default: "pending", null: false
    t.integer  "member_id"
    t.text     "squads",      default: [],                     array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["member_id"], name: "index_app_invites_on_member_id", using: :btree
    t.index ["site_id", "email"], name: "index_app_invites_on_site_id_and_email", unique: true, using: :btree
    t.index ["site_id", "invite_code"], name: "index_app_invites_on_site_id_and_invite_code", unique: true, using: :btree
    t.index ["site_id", "member_id"], name: "index_app_invites_on_site_id_and_member_id", unique: true, using: :btree
    t.index ["site_id"], name: "index_app_invites_on_site_id", using: :btree
    t.index ["slug"], name: "index_app_invites_on_slug", unique: true, using: :btree
    t.index ["squads"], name: "index_app_invites_on_squads", using: :gin
  end

  create_table "auto_content_rules", force: :cascade do |t|
    t.integer  "board_id",                                      null: false
    t.integer  "magic_number",                  default: 0,     null: false
    t.text     "value",                                         null: false
    t.string   "type",              limit: 255,                 null: false
    t.string   "provider_name",     limit: 255
    t.boolean  "active",                        default: true,  null: false
    t.string   "content_type",      limit: 255, default: "any", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "negative_tags",     limit: 255
    t.string   "positive_tags",     limit: 255
    t.integer  "radius",                        default: 1,     null: false
    t.boolean  "moderate_items",                default: true,  null: false
    t.boolean  "reactive",                      default: false, null: false
    t.datetime "last_enqueued_at"
    t.string   "slug",                                          null: false
    t.string   "provider_id"
    t.boolean  "pull_old",                      default: false, null: false
    t.integer  "pull_from_timeout"
    t.index ["board_id", "type"], name: "index_auto_content_rules_on_board_id_and_type", using: :btree
    t.index ["board_id"], name: "index_auto_content_rules_on_board_id", using: :btree
    t.index ["slug"], name: "index_auto_content_rules_on_slug", unique: true, using: :btree
  end

  create_table "auto_content_rules_instagram_subscriptions", id: false, force: :cascade do |t|
    t.integer "instagram_subscription_id", null: false
    t.integer "auto_content_rule_id",      null: false
  end

  create_table "board_designs", force: :cascade do |t|
    t.integer  "board_id",           null: false
    t.text     "header_html"
    t.text     "custom_css"
    t.text     "footer_html"
    t.text     "mobile_header_html"
    t.text     "mobile_footer_html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["board_id"], name: "index_board_designs_on_board_id", unique: true, using: :btree
  end

  create_table "board_items", id: :integer, default: -> { "nextval('media_board_items_id_seq'::regclass)" }, force: :cascade do |t|
    t.string   "name",                     limit: 255,                                              null: false
    t.string   "type",                     limit: 255,                                              null: false
    t.string   "image_uid",                limit: 2048
    t.text     "content"
    t.integer  "num_likes",                                                     default: 0,         null: false
    t.integer  "num_complaints",                                                default: 0,         null: false
    t.string   "slug",                     limit: 255,                                              null: false
    t.integer  "member_id",                                                                         null: false
    t.integer  "board_id",                                                                          null: false
    t.datetime "created_at",                                                                        null: false
    t.datetime "updated_at",                                                                        null: false
    t.integer  "num_comments",                                                  default: 0,         null: false
    t.integer  "num_shares",                                                    default: 0,         null: false
    t.integer  "width"
    t.integer  "height"
    t.bigint   "size"
    t.string   "info_url",                 limit: 255
    t.string   "image_alt_text",           limit: 255
    t.string   "status",                   limit: 255,                          default: "visible", null: false
    t.boolean  "show_as_site_upload",                                           default: false,     null: false
    t.string   "source_url",               limit: 255
    t.text     "tags",                                                                                           array: true
    t.string   "creator_name",             limit: 255
    t.string   "creator_username",         limit: 255
    t.string   "creator_avatar",           limit: 255
    t.string   "provider_name",            limit: 255
    t.string   "provider_id",              limit: 255
    t.text     "image_source_url"
    t.boolean  "generate_thumbnails",                                           default: false,     null: false
    t.hstore   "options",                                                       default: {},        null: false
    t.hstore   "activities",                                                    default: {},        null: false
    t.datetime "last_activity_at"
    t.integer  "site_id",                                                                           null: false
    t.integer  "rotation"
    t.string   "original_image_uid",       limit: 2048
    t.integer  "copied_from_id"
    t.boolean  "agreed_to_terms",                                               default: false,     null: false
    t.boolean  "direct_image_uid",                                              default: false
    t.string   "creator_id",               limit: 255
    t.decimal  "latitude",                              precision: 9, scale: 6
    t.decimal  "longitude",                             precision: 9, scale: 6
    t.integer  "social_likes_count",                                            default: 0
    t.datetime "social_likes_updated_at"
    t.boolean  "is_starred",                                                    default: false,     null: false
    t.text     "search_tags",                                                                                    array: true
    t.boolean  "approved_for_advertising",                                      default: false,     null: false
    t.integer  "random_id",                                                                         null: false
    t.string   "parent_read_access",                                            default: "public"
    t.integer  "squad_task_id"
    t.text     "rejection_reason"
    t.integer  "squad_id"
    t.integer  "approval_id"
    t.string   "approval_status"
    t.index "st_geographyfromtext((((('SRID=4326;POINT('::text || longitude) || ' '::text) || latitude) || ')'::text))", name: "index_on_board_items_location", using: :gist
    t.index ["board_id", "provider_name", "provider_id"], name: "index_board_items_on_board_id_and_provider_name_and_provider_id", unique: true, where: "((provider_name IS NOT NULL) AND (provider_id IS NOT NULL))", using: :btree
    t.index ["board_id", "status"], name: "index_board_items_on_board_id_and_status", using: :btree
    t.index ["board_id"], name: "index_media_board_items_on_media_board_id", using: :btree
    t.index ["generate_thumbnails"], name: "index_board_items_on_generate_thumbnails", using: :btree
    t.index ["last_activity_at"], name: "index_board_items_on_last_activity_at", using: :btree
    t.index ["member_id", "squad_task_id"], name: "index_board_items_on_member_id_and_squad_task_id", using: :btree
    t.index ["member_id"], name: "index_media_board_items_on_member_id", using: :btree
    t.index ["search_tags"], name: "index_board_items_on_search_tags", using: :gin
    t.index ["site_id", "status", "is_starred", "created_at"], name: "index_on_board_items_site_id_and_created_at_asc", order: { is_starred: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "created_at"], name: "index_on_board_items_site_id_and_created_at_desc", order: { is_starred: :desc, created_at: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "num_comments", "created_at"], name: "index_on_board_items_site_id_and_num_comments_asc", order: { is_starred: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "num_comments", "created_at"], name: "index_on_board_items_site_id_and_num_comments_desc", order: { is_starred: :desc, num_comments: :desc, created_at: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "num_likes", "created_at"], name: "index_on_board_items_site_id_and_num_likes_asc", order: { is_starred: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "num_likes", "created_at"], name: "index_on_board_items_site_id_and_num_likes_desc", order: { is_starred: :desc, num_likes: :desc, created_at: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "num_shares", "created_at"], name: "index_on_board_items_site_id_and_num_shares_asc", order: { is_starred: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "num_shares", "created_at"], name: "index_on_board_items_site_id_and_num_shares_desc", order: { is_starred: :desc, num_shares: :desc, created_at: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "random_id", "creator_name"], name: "index_on_board_items_random_id", order: { is_starred: :desc, random_id: :desc, creator_name: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "social_likes_count", "num_likes", "created_at"], name: "index_on_board_items_site_id_and_social_likes_count_asc", order: { is_starred: :desc }, using: :btree
    t.index ["site_id", "status", "is_starred", "social_likes_count", "num_likes", "created_at"], name: "index_on_board_items_site_id_and_social_likes_count_desc", order: { is_starred: :desc, social_likes_count: :desc, num_likes: :desc, created_at: :desc }, using: :btree
    t.index ["site_id", "status", "parent_read_access"], name: "index_on_board_items_status_and_parent_read_access", using: :btree
    t.index ["site_id"], name: "index_board_items_on_site_id", using: :btree
    t.index ["slug"], name: "index_media_board_items_on_slug", unique: true, using: :btree
    t.index ["source_url"], name: "index_board_items_on_source_url", using: :btree
    t.index ["squad_id"], name: "index_board_items_on_squad_id", using: :btree
    t.index ["squad_task_id"], name: "index_board_items_on_squad_task_id", using: :btree
    t.index ["status", "parent_read_access", "created_at"], name: "index_on_board_items_created_at_desc", order: { created_at: :desc }, using: :btree
    t.index ["tags"], name: "index_board_items_on_tags", using: :gin
    t.index ["type"], name: "index_media_board_items_on_type", using: :btree
  end

  create_table "board_items_products", id: false, force: :cascade do |t|
    t.integer "product_id",    null: false
    t.integer "board_item_id", null: false
    t.index ["board_item_id"], name: "index_board_items_products_on_board_item_id", using: :btree
    t.index ["product_id", "board_item_id"], name: "index_board_items_products_on_product_id_and_board_item_id", unique: true, using: :btree
  end

  create_table "board_weights", force: :cascade do |t|
    t.integer "site_id"
    t.integer "board_id"
    t.float   "weight",   default: 0.0
  end

  create_table "boards", id: :integer, default: -> { "nextval('media_boards_id_seq'::regclass)" }, force: :cascade do |t|
    t.string   "name",                      limit: 255,                        null: false
    t.text     "description",                                                  null: false
    t.text     "requirements"
    t.boolean  "allow_photos",                          default: true,         null: false
    t.boolean  "allow_multiple_entries",                default: true,         null: false
    t.datetime "submission_start_date"
    t.datetime "submission_end_date"
    t.datetime "voting_start_date"
    t.datetime "voting_end_date"
    t.string   "slug",                      limit: 255,                        null: false
    t.integer  "site_id",                                                      null: false
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.string   "cover_image_uid",           limit: 255
    t.string   "item_type",                 limit: 255,                        null: false
    t.boolean  "allow_comments",                        default: true,         null: false
    t.string   "write_access",              limit: 255, default: "public",     null: false
    t.integer  "owner_id"
    t.text     "keywords"
    t.boolean  "moderate_board_items",                  default: false,        null: false
    t.string   "info_link_text",            limit: 255
    t.text     "share_heading"
    t.text     "share_instructions"
    t.text     "share_facebook_text"
    t.string   "share_twitter_text",        limit: 255
    t.boolean  "moderate_comments",                     default: false,        null: false
    t.integer  "num_comments",                          default: 0,            null: false
    t.integer  "num_complaints",                        default: 0,            null: false
    t.integer  "num_likes",                             default: 0,            null: false
    t.integer  "num_shares",                            default: 0,            null: false
    t.integer  "pull_max_items",                        default: 20,           null: false
    t.integer  "magic_number",                          default: 0,            null: false
    t.string   "board_items_order",         limit: 255, default: "votes_desc", null: false
    t.text     "post_entry_message"
    t.string   "post_email",                limit: 255
    t.boolean  "posting_by_email",                      default: false,        null: false
    t.boolean  "require_terms_agreement",               default: false,        null: false
    t.string   "terms_url",                 limit: 255
    t.integer  "num_submissions",                       default: 0
    t.integer  "priority",                              default: 0,            null: false
    t.boolean  "requires_permission",                   default: false,        null: false
    t.integer  "twitter_oauth_token_id"
    t.string   "read_access",               limit: 255, default: "public",     null: false
    t.string   "bar_hash",                  limit: 255
    t.boolean  "fixed_charge_for_upload",               default: false,        null: false
    t.integer  "fixed_upload_cost_cents",               default: 0,            null: false
    t.boolean  "payout_for_upload",                     default: false,        null: false
    t.integer  "payout_amount_cents",                   default: 0,            null: false
    t.datetime "design_updated_at"
    t.string   "encrypted_password",        limit: 255
    t.boolean  "minimal_charge_for_upload",             default: false,        null: false
    t.integer  "minimal_upload_cost_cents",             default: 0,            null: false
    t.boolean  "send_thank_you",                        default: false,        null: false
    t.string   "thank_you_message",         limit: 255
    t.string   "status",                    limit: 255, default: "visible",    null: false
    t.boolean  "attempt_to_guess_name",                 default: true,         null: false
    t.boolean  "classifier",                            default: false,        null: false
    t.string   "vote_frequency",            limit: 32,  default: "per_entry",  null: false
    t.boolean  "anonymous_uploads",                     default: false,        null: false
    t.boolean  "anonymous_votes",                       default: false,        null: false
    t.boolean  "anonymous_comments",                    default: false,        null: false
    t.boolean  "direct_cover_image_uid",                default: false,        null: false
    t.boolean  "is_default_upload_board",               default: false,        null: false
    t.integer  "instagram_oauth_token_id"
    t.integer  "youtube_oauth_token_id"
    t.index ["num_comments"], name: "index_boards_on_num_comments", using: :btree
    t.index ["num_complaints"], name: "index_boards_on_num_complaints", using: :btree
    t.index ["num_likes"], name: "index_boards_on_num_likes", using: :btree
    t.index ["num_shares"], name: "index_boards_on_num_shares", using: :btree
    t.index ["post_email"], name: "index_boards_on_post_email", unique: true, using: :btree
    t.index ["site_id", "is_default_upload_board"], name: "index_boards_on_site_id_and_is_default_upload_board", unique: true, where: "(is_default_upload_board IS TRUE)", using: :btree
    t.index ["site_id", "status"], name: "index_boards_on_site_id_and_status", using: :btree
    t.index ["site_id"], name: "index_media_boards_on_site_id", using: :btree
    t.index ["slug"], name: "index_media_boards_on_slug", unique: true, using: :btree
    t.index ["submission_end_date"], name: "index_media_boards_on_submission_end_date", using: :btree
    t.index ["submission_start_date"], name: "index_media_boards_on_submission_start_date", using: :btree
    t.index ["voting_end_date"], name: "index_media_boards_on_voting_end_date", using: :btree
    t.index ["voting_start_date"], name: "index_media_boards_on_voting_start_date", using: :btree
  end

  create_table "boards_products", id: false, force: :cascade do |t|
    t.integer "board_id",   null: false
    t.integer "product_id", null: false
    t.index ["board_id", "product_id"], name: "index_boards_products_on_board_id_and_product_id", unique: true, using: :btree
    t.index ["board_id"], name: "index_boards_products_on_board_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",                                          null: false
    t.integer  "num_likes",                    default: 0,         null: false
    t.integer  "num_complaints",               default: 0,         null: false
    t.integer  "member_id",                                        null: false
    t.integer  "board_item_id",                                    null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "status",           limit: 255, default: "visible", null: false
    t.string   "content_language", limit: 5
    t.string   "slug",             limit: 255,                     null: false
    t.index ["board_item_id"], name: "index_comments_on_board_item_id", using: :btree
    t.index ["member_id", "board_item_id"], name: "index_comments_on_member_id_and_board_item_id", using: :btree
    t.index ["member_id", "created_at"], name: "index_comments_on_member_id_and_created_at", using: :btree
    t.index ["member_id"], name: "index_comments_on_member_id", using: :btree
    t.index ["slug"], name: "index_comments_on_slug", unique: true, using: :btree
  end

  create_table "complaints", force: :cascade do |t|
    t.boolean  "resource_visible",             default: true,  null: false
    t.boolean  "actioned",                     default: false, null: false
    t.integer  "member_id",                                    null: false
    t.integer  "resource_id",                                  null: false
    t.string   "resource_type",    limit: 255,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "reason"
    t.boolean  "ban_user",                     default: false, null: false
    t.string   "slug",             limit: 255,                 null: false
    t.index ["actioned", "resource_visible"], name: "index_complaints_on_actioned_and_resource_visible", using: :btree
    t.index ["actioned"], name: "index_complaints_on_actioned", using: :btree
    t.index ["member_id", "resource_type", "resource_id"], name: "index_complaints_on_member_id_and_resource_type_and_resource_id", unique: true, using: :btree
    t.index ["member_id"], name: "index_complaints_on_member_id", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_complaints_on_resource_type_and_resource_id", using: :btree
    t.index ["resource_visible"], name: "index_complaints_on_resource_visible", using: :btree
    t.index ["slug"], name: "index_complaints_on_slug", unique: true, using: :btree
  end

  create_table "coupon_rules", force: :cascade do |t|
    t.string   "name",                    limit: 255,                    null: false
    t.text     "description",                                            null: false
    t.integer  "board_id",                                               null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "status",                  limit: 255, default: "paused", null: false
    t.string   "slug",                    limit: 255,                    null: false
    t.boolean  "generate_on_demand",                  default: true,     null: false
    t.integer  "every_nth_person",                    default: 1,        null: false
    t.integer  "num_issuable_per_person"
    t.integer  "num_issuable_total"
    t.integer  "num_considered",                      default: 0,        null: false
    t.integer  "num_issued",                          default: 0,        null: false
    t.string   "redemption_button_text",  limit: 255
    t.string   "email_subject",           limit: 255,                    null: false
    t.text     "email_content",                                          null: false
    t.string   "global_code",             limit: 255
    t.text     "triggers",                                                            array: true
    t.string   "redeemable_hours_0",      limit: 24
    t.string   "redeemable_hours_1",      limit: 24
    t.string   "redeemable_hours_2",      limit: 24
    t.string   "redeemable_hours_3",      limit: 24
    t.string   "redeemable_hours_4",      limit: 24
    t.string   "redeemable_hours_5",      limit: 24
    t.string   "redeemable_hours_6",      limit: 24
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.datetime "issue_start_time"
    t.datetime "issue_end_time"
    t.index ["board_id", "status"], name: "index_coupon_rules_on_board_id_and_status", using: :btree
    t.index ["board_id", "triggers", "status", "start_time", "end_time"], name: "index_coupon_rules_on_board_lookup_for_trigger", using: :btree
    t.index ["board_id"], name: "index_coupon_rules_on_board_id", using: :btree
    t.index ["end_time"], name: "index_coupon_rules_on_end_time", using: :btree
    t.index ["slug"], name: "index_coupon_rules_on_slug", unique: true, using: :btree
    t.index ["start_time", "end_time"], name: "index_coupon_rules_on_start_time_and_end_time", using: :btree
    t.index ["start_time"], name: "index_coupon_rules_on_start_time", using: :btree
    t.index ["status"], name: "index_coupon_rules_on_status", using: :btree
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code",                   limit: 255,                 null: false
    t.integer  "coupon_rule_id",                                     null: false
    t.integer  "board_item_id"
    t.integer  "member_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "name",                   limit: 255,                 null: false
    t.text     "description",                                        null: false
    t.string   "status",                 limit: 255,                 null: false
    t.integer  "trigger_id"
    t.string   "trigger_type",           limit: 255
    t.string   "slug",                   limit: 255,                 null: false
    t.boolean  "is_custom_format",                   default: false, null: false
    t.string   "redemption_button_text", limit: 255
    t.datetime "redeemed_at"
    t.string   "redeemed_ip",            limit: 255
    t.string   "redeemable_hours_0",     limit: 24
    t.string   "redeemable_hours_1",     limit: 24
    t.string   "redeemable_hours_2",     limit: 24
    t.string   "redeemable_hours_3",     limit: 24
    t.string   "redeemable_hours_4",     limit: 24
    t.string   "redeemable_hours_5",     limit: 24
    t.string   "redeemable_hours_6",     limit: 24
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.index ["board_item_id"], name: "index_coupons_on_board_item_id", using: :btree
    t.index ["code"], name: "index_coupons_on_code", using: :btree
    t.index ["coupon_rule_id"], name: "index_coupons_on_coupon_rule_id", using: :btree
    t.index ["member_id", "board_item_id"], name: "index_coupons_on_member_id_and_board_item_id", using: :btree
    t.index ["member_id", "coupon_rule_id"], name: "index_coupons_on_member_id_and_coupon_rule_id", using: :btree
    t.index ["member_id"], name: "index_coupons_on_member_id", using: :btree
    t.index ["slug"], name: "index_coupons_on_slug", unique: true, using: :btree
    t.index ["status"], name: "index_coupons_on_status", using: :btree
    t.index ["trigger_id", "trigger_type"], name: "index_coupons_on_trigger_id_and_trigger_type", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0
    t.integer  "attempts",               default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "queue",      limit: 255
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "email_templates", force: :cascade do |t|
    t.integer  "site_id",                null: false
    t.string   "locale",     limit: 255, null: false
    t.string   "subject",    limit: 255, null: false
    t.text     "content",                null: false
    t.string   "key",        limit: 255, null: false
    t.string   "slug",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["site_id", "locale", "key"], name: "index_email_templates_on_site_id_and_locale_and_key", unique: true, using: :btree
    t.index ["slug"], name: "index_email_templates_on_slug", unique: true, using: :btree
  end

  create_table "instagram_subscriptions", force: :cascade do |t|
    t.bigint   "subscription_id"
    t.integer  "site_id",                         null: false
    t.string   "state",           default: "new", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "options",         default: {},    null: false
    t.index ["options"], name: "index_instagram_subscriptions_on_options", using: :gin
    t.index ["site_id"], name: "index_instagram_subscriptions_on_site_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "member_id",                             null: false
    t.integer  "board_item_id",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "voter_profile", limit: 255
    t.integer  "num_likes",                 default: 1, null: false
    t.datetime "last_liked_at"
    t.index ["board_item_id"], name: "index_likes_on_board_item_id", using: :btree
    t.index ["member_id", "board_item_id"], name: "index_likes_on_member_id_and_board_item_id", unique: true, using: :btree
    t.index ["member_id"], name: "index_likes_on_member_id", using: :btree
    t.index ["voter_profile"], name: "index_likes_on_voter_profile", using: :btree
  end

  create_table "line_users", force: :cascade do |t|
    t.string   "username"
    t.string   "mid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_roles", force: :cascade do |t|
    t.integer "member_id",                                         null: false
    t.integer "site_id",                                           null: false
    t.string  "role",               limit: 255, default: "member", null: false
    t.boolean "is_case_worker",                 default: false,    null: false
    t.boolean "send_promo_mails",               default: false,    null: false
    t.boolean "send_status_mails",              default: true,     null: false
    t.boolean "send_manager_mails",             default: false,    null: false
    t.index ["member_id", "site_id"], name: "index_member_roles_on_member_id_and_site_id", unique: true, using: :btree
    t.index ["member_id"], name: "index_member_roles_on_member_id", using: :btree
    t.index ["role"], name: "index_member_roles_on_role", using: :btree
    t.index ["send_promo_mails"], name: "index_member_roles_on_send_promo_mails", using: :btree
    t.index ["site_id", "is_case_worker"], name: "index_members_sites_on_site_and_case_worker", using: :btree
    t.index ["site_id", "role"], name: "index_member_roles_on_site_id_and_role", using: :btree
    t.index ["site_id", "send_promo_mails"], name: "index_member_roles_on_site_id_and_send_promo_mails", using: :btree
    t.index ["site_id"], name: "index_member_roles_on_site_id", using: :btree
  end

  create_table "member_squad_tasks", force: :cascade do |t|
    t.integer  "member_id",     null: false
    t.integer  "squad_task_id", null: false
    t.string   "status",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["member_id", "squad_task_id"], name: "index_member_squad_tasks_on_member_id_and_squad_task_id", unique: true, using: :btree
    t.index ["member_id"], name: "index_member_squad_tasks_on_member_id", using: :btree
    t.index ["squad_task_id"], name: "index_member_squad_tasks_on_squad_task_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.bigint   "facebook_id"
    t.string   "name",                      limit: 255
    t.string   "email",                     limit: 255
    t.string   "gender",                    limit: 255
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                limit: 255
    t.string   "last_name",                 limit: 255
    t.string   "link",                      limit: 255
    t.string   "location",                  limit: 255
    t.string   "picture",                   limit: 255
    t.string   "hometown",                  limit: 255
    t.string   "languages",                 limit: 255
    t.string   "locale",                    limit: 255
    t.string   "political",                 limit: 255
    t.string   "religion",                  limit: 255
    t.string   "timezone",                  limit: 255
    t.string   "facebook_username",         limit: 255
    t.string   "verified",                  limit: 255
    t.string   "oauth2_token",              limit: 255
    t.string   "encrypted_password",        limit: 255,                          default: "",       null: false
    t.string   "reset_password_token",      limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                  default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",        limit: 255
    t.string   "last_sign_in_ip",           limit: 255
    t.integer  "failed_attempts",                                                default: 0
    t.string   "unlock_token",              limit: 255
    t.datetime "locked_at"
    t.text     "facebook_permissions"
    t.string   "oauth2_token_secret",       limit: 255
    t.bigint   "twitter_id"
    t.text     "twitter_permissions"
    t.string   "twitter_username",          limit: 255
    t.string   "slug",                      limit: 255
    t.boolean  "explicit_timezone",                                              default: false
    t.string   "confirmation_token",        limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",         limit: 255
    t.string   "api_v2_token",              limit: 255
    t.boolean  "restrict_api_access"
    t.integer  "site_id"
    t.string   "bare_email",                limit: 255
    t.string   "role",                      limit: 255,                          default: "member", null: false
    t.boolean  "send_promo_mails",                                               default: false,    null: false
    t.boolean  "send_status_mails",                                              default: true,     null: false
    t.boolean  "send_manager_mails",                                             default: false,    null: false
    t.hstore   "customer_attributes",                                            default: {},       null: false
    t.decimal  "latitude",                               precision: 9, scale: 6
    t.decimal  "longitude",                              precision: 9, scale: 6
    t.string   "third_party_id"
    t.string   "third_party_provider"
    t.string   "encrypted_otp_secret"
    t.string   "encrypted_otp_secret_iv"
    t.string   "encrypted_otp_secret_salt"
    t.boolean  "otp_required_for_login"
    t.string   "otp_backup_codes",                                                                               array: true
    t.datetime "picture_updated_at"
    t.integer  "consumed_timestep"
    t.integer  "num_comments",                                                   default: 0,        null: false
    t.integer  "num_complaints",                                                 default: 0,        null: false
    t.integer  "num_likes",                                                      default: 0,        null: false
    t.integer  "num_shares",                                                     default: 0,        null: false
    t.string   "devise_return_url",         limit: 2048
    t.bigint   "instagram_id"
    t.string   "instagram_username",        limit: 255
    t.jsonb    "intercom_options"
    t.index "st_geographyfromtext((((('SRID=4326;POINT('::text || longitude) || ' '::text) || latitude) || ')'::text))", name: "index_on_members_location", using: :gist
    t.index ["api_v2_token"], name: "index_members_on_api_v2_token", unique: true, using: :btree
    t.index ["bare_email"], name: "index_members_on_bare_email", using: :btree
    t.index ["birthday"], name: "index_members_on_birthday", using: :btree
    t.index ["confirmation_token"], name: "index_members_on_confirmation_token", unique: true, using: :btree
    t.index ["gender"], name: "index_members_on_gender", using: :btree
    t.index ["name"], name: "index_members_on_name", using: :btree
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", using: :btree
    t.index ["site_id", "email"], name: "index_members_on_site_id_and_email", unique: true, using: :btree
    t.index ["site_id", "facebook_id"], name: "index_members_on_site_id_and_facebook_id", unique: true, using: :btree
    t.index ["site_id", "instagram_id"], name: "index_members_on_site_id_and_instagram_id", unique: true, using: :btree
    t.index ["site_id", "twitter_id"], name: "index_members_on_site_id_and_twitter_id", unique: true, using: :btree
    t.index ["slug"], name: "index_members_on_slug", unique: true, using: :btree
  end

  create_table "members_squads", id: false, force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "squad_id",  null: false
    t.index ["member_id"], name: "index_members_squads_on_member_id", using: :btree
    t.index ["squad_id", "member_id"], name: "index_members_squads_on_squad_id_and_member_id", unique: true, using: :btree
    t.index ["squad_id"], name: "index_members_squads_on_squad_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "message"
    t.integer  "line_user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "is_response",          default: false
    t.string   "message_type"
    t.string   "shuttlerock_image_id"
    t.index ["line_user_id"], name: "index_messages_on_line_user_id", using: :btree
  end

  create_table "mobile_app_designs", force: :cascade do |t|
    t.integer  "site_id",                                    null: false
    t.string   "company_logo_uid", limit: 2048
    t.string   "circled_logo_uid", limit: 2048
    t.hstore   "colors",                        default: {}, null: false
    t.hstore   "urls",                          default: {}, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["site_id"], name: "index_mobile_app_designs_on_site_id", unique: true, using: :btree
  end

  create_table "moderations", force: :cascade do |t|
    t.string   "status",            limit: 255,  default: "pending", null: false
    t.integer  "resource_id",                                        null: false
    t.string   "resource_type",     limit: 255,                      null: false
    t.integer  "requester_id",                                       null: false
    t.integer  "moderator_id"
    t.integer  "site_id",                                            null: false
    t.string   "slug",              limit: 255,                      null: false
    t.datetime "moderated_at"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "board_id"
    t.integer  "approval_id"
    t.float    "spamprob"
    t.text     "rejection_reasons",                                               array: true
    t.string   "rejection_details", limit: 3000
    t.string   "approval_status"
    t.boolean  "sent_thank_you"
    t.boolean  "ask_for_consent",                default: false
    t.index ["board_id"], name: "index_moderations_on_board_id", using: :btree
    t.index ["resource_id", "resource_type"], name: "index_moderations_on_resource_id_and_resource_type", using: :btree
    t.index ["site_id", "moderator_id"], name: "index_moderations_on_site_id_and_moderator_id", using: :btree
    t.index ["site_id", "requester_id"], name: "index_moderations_on_site_id_and_requester_id", using: :btree
    t.index ["site_id", "resource_id", "resource_type", "requester_id"], name: "index_moderations_on_site_resource_and_requester", unique: true, using: :btree
    t.index ["site_id", "status", "created_at", "id", "resource_id", "resource_type", "requester_id", "moderator_id", "slug", "moderated_at", "updated_at", "board_id", "approval_id", "spamprob"], name: "index_moderations_on_created_at_asc", using: :btree
    t.index ["site_id", "status", "created_at", "id", "resource_id", "resource_type", "requester_id", "moderator_id", "slug", "moderated_at", "updated_at", "board_id", "approval_id", "spamprob"], name: "index_moderations_on_created_at_desc", order: { created_at: :desc }, using: :btree
    t.index ["site_id", "status", "resource_type", "created_at", "id", "resource_id", "requester_id", "moderator_id", "slug", "moderated_at", "updated_at", "board_id", "approval_id", "spamprob"], name: "index_moderations_on_created_at_asc_and_resource_type", using: :btree
    t.index ["site_id", "status", "resource_type", "created_at", "id", "resource_id", "requester_id", "moderator_id", "slug", "moderated_at", "updated_at", "board_id", "approval_id", "spamprob"], name: "index_moderations_on_created_at_desc_and_resource_type", order: { created_at: :desc }, using: :btree
    t.index ["site_id", "status", "resource_type", "spamprob", "created_at", "id", "resource_id", "requester_id", "moderator_id", "slug", "moderated_at", "updated_at", "board_id", "approval_id"], name: "index_moderations_on_spamprob_asc_and_resource_type", order: { created_at: :desc }, using: :btree
    t.index ["site_id", "status", "resource_type", "spamprob", "created_at", "id", "resource_id", "requester_id", "moderator_id", "slug", "moderated_at", "updated_at", "board_id", "approval_id"], name: "index_moderations_on_spamprob_desc_and_resource_type", order: { spamprob: :desc, created_at: :desc }, using: :btree
    t.index ["site_id", "status", "spamprob", "created_at", "id", "resource_id", "resource_type", "requester_id", "moderator_id", "slug", "moderated_at", "updated_at", "board_id", "approval_id"], name: "index_moderations_on_spamprob_asc", order: { created_at: :desc }, using: :btree
    t.index ["site_id", "status", "spamprob", "created_at", "id", "resource_id", "resource_type", "requester_id", "moderator_id", "slug", "moderated_at", "updated_at", "board_id", "approval_id"], name: "index_moderations_on_spamprob_desc", order: { spamprob: :desc, created_at: :desc }, using: :btree
    t.index ["site_id", "status"], name: "index_moderations_on_site_id_and_status", using: :btree
    t.index ["site_id"], name: "index_moderations_on_site_id", using: :btree
    t.index ["slug"], name: "index_moderations_on_slug", unique: true, using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "resource_id",               null: false
    t.text     "message",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resource_type", limit: 255, null: false
    t.index ["resource_id", "resource_type"], name: "index_notifications_on_resource_id_and_resource_type", using: :btree
  end

  create_table "oauth_tokens", force: :cascade do |t|
    t.integer  "resource_id",                            null: false
    t.string   "resource_type",              limit: 255, null: false
    t.integer  "site_id",                                null: false
    t.string   "name",                       limit: 255, null: false
    t.string   "provider",                   limit: 255, null: false
    t.string   "provider_id",                limit: 255, null: false
    t.text     "encrypted_v1_token_secret"
    t.text     "permissions"
    t.string   "slug",                       limit: 255, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.text     "encrypted_v1_refresh_token"
    t.integer  "expires_at"
    t.text     "encrypted_token",                        null: false
    t.string   "encrypted_token_iv",                     null: false
    t.text     "encrypted_token_secret"
    t.string   "encrypted_token_secret_iv"
    t.text     "encrypted_refresh_token"
    t.string   "encrypted_refresh_token_iv"
    t.index ["resource_type", "resource_id", "site_id", "provider", "provider_id"], name: "index_oauth_tokens_on_resource_site_provider_and_provider_id", unique: true, using: :btree
    t.index ["resource_type", "resource_id", "site_id"], name: "index_oauth_tokens_on_resource_and_site_id", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_oauth_tokens_on_resource_type_and_resource_id", using: :btree
    t.index ["slug"], name: "index_oauth_tokens_on_slug", unique: true, using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.string   "payable_type",    limit: 255,                 null: false
    t.integer  "payable_id",                                  null: false
    t.integer  "member_id",                                   null: false
    t.integer  "site_id",                                     null: false
    t.integer  "amount_cents",                default: 0,     null: false
    t.string   "amount_currency", limit: 255, default: "USD", null: false
    t.string   "card_token",      limit: 255,                 null: false
    t.string   "charge_token",    limit: 255
    t.string   "status",          limit: 255,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "charged_at"
    t.string   "error_message",   limit: 255
    t.index ["member_id"], name: "index_payments_on_member_id", using: :btree
    t.index ["payable_type", "payable_id"], name: "index_payments_on_payable_type_and_payable_id", using: :btree
    t.index ["site_id"], name: "index_payments_on_site_id", using: :btree
    t.index ["status"], name: "index_payments_on_status", using: :btree
  end

  create_table "payouts", force: :cascade do |t|
    t.string   "payable_type",    limit: 255,                 null: false
    t.integer  "payable_id",                                  null: false
    t.integer  "member_id",                                   null: false
    t.integer  "site_id",                                     null: false
    t.string   "email",           limit: 255,                 null: false
    t.integer  "amount_cents",                default: 0,     null: false
    t.string   "amount_currency", limit: 255, default: "USD", null: false
    t.string   "status",          limit: 255,                 null: false
    t.string   "transaction_id",  limit: 255
    t.string   "error_code",      limit: 255
    t.string   "error_message",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["member_id"], name: "index_payouts_on_member_id", using: :btree
    t.index ["payable_type", "payable_id"], name: "index_payouts_on_payable_type_and_payable_id", using: :btree
    t.index ["site_id"], name: "index_payouts_on_site_id", using: :btree
    t.index ["status"], name: "index_payouts_on_status", using: :btree
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type",          limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "site_id",                              null: false
    t.tsvector "tsvector_content_tsearch"
    t.index ["searchable_id", "searchable_type"], name: "index_pg_search_documents_on_searchable_id_and_searchable_type", using: :btree
    t.index ["site_id"], name: "index_pg_search_documents_on_site_id", using: :btree
    t.index ["tsvector_content_tsearch"], name: "index_pg_search_documents_on_tsvector_content_tsearch", using: :gin
  end

  create_table "products", force: :cascade do |t|
    t.integer  "site_id"
    t.string   "url",                     limit: 2048,                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                    limit: 255
    t.text     "description"
    t.string   "image_uid",               limit: 255
    t.string   "status",                  limit: 255,  default: "pending", null: false
    t.string   "slug",                    limit: 255,                      null: false
    t.json     "ad_options",                           default: "{}",      null: false
    t.text     "tags",                                                                  array: true
    t.text     "search_tags",                                                           array: true
    t.text     "locations",                                                             array: true
    t.text     "search_locations",                                                      array: true
    t.bigint   "size"
    t.integer  "width"
    t.integer  "height"
    t.boolean  "direct_image_uid",                     default: false,     null: false
    t.text     "suggested_tags",                       default: [],                     array: true
    t.boolean  "is_default_site_product",              default: false,     null: false
    t.text     "auto_attach_tags",                                                      array: true
    t.text     "search_auto_attach_tags",                                               array: true
    t.string   "button_text",             limit: 255
    t.boolean  "use_ads_redirect_urls",                default: false,     null: false
    t.index ["search_auto_attach_tags"], name: "index_products_on_search_auto_attach_tags", using: :gin
    t.index ["search_locations"], name: "index_products_on_search_locations", using: :gin
    t.index ["search_tags"], name: "index_products_on_search_tags", using: :gin
    t.index ["site_id", "is_default_site_product"], name: "index_products_on_site_id_and_is_default_site_product", unique: true, where: "(is_default_site_product IS TRUE)", using: :btree
    t.index ["site_id", "url"], name: "index_products_on_site_id_and_url", unique: true, using: :btree
    t.index ["site_id"], name: "index_products_on_site_id", using: :btree
    t.index ["slug"], name: "index_products_on_slug", unique: true, using: :btree
    t.index ["suggested_tags"], name: "index_products_on_suggested_tags", using: :gin
  end

  create_table "products_pulled_board_items", id: false, force: :cascade do |t|
    t.integer "product_id",           null: false
    t.integer "pulled_board_item_id", null: false
    t.index ["product_id", "pulled_board_item_id"], name: "index_products_p_board_items_on_product_id_and_p_board_item_id", unique: true, using: :btree
    t.index ["pulled_board_item_id"], name: "index_products_pulled_board_items_on_pulled_board_item_id", using: :btree
  end

  create_table "pulled_board_items", force: :cascade do |t|
    t.integer  "board_id",                                                                              null: false
    t.integer  "member_id",                                                                             null: false
    t.string   "name",                     limit: 255
    t.text     "content"
    t.text     "image_url"
    t.text     "review_image_url"
    t.text     "thumbnail_url"
    t.string   "provider_name",            limit: 255,                                                  null: false
    t.string   "provider_id",              limit: 255,                                                  null: false
    t.string   "source_url",               limit: 255,                                                  null: false
    t.string   "creator_name",             limit: 255,                                                  null: false
    t.string   "status",                   limit: 255,                                                  null: false
    t.datetime "created_at",                                                                            null: false
    t.datetime "updated_at",                                                                            null: false
    t.text     "tags",                                                                                               array: true
    t.string   "creator_username",         limit: 255
    t.string   "creator_avatar",           limit: 255
    t.string   "content_type",             limit: 255,                                                  null: false
    t.hstore   "options",                                                      default: {},             null: false
    t.datetime "pulled_at",                                                    default: -> { "now()" }, null: false
    t.string   "creator_id",               limit: 255
    t.decimal  "latitude",                             precision: 9, scale: 6
    t.decimal  "longitude",                            precision: 9, scale: 6
    t.float    "spamprob"
    t.integer  "auto_content_rule_id"
    t.boolean  "approved_for_advertising",                                     default: false,          null: false
    t.index ["auto_content_rule_id"], name: "index_pulled_board_items_on_auto_content_rule_id", using: :btree
    t.index ["board_id", "provider_name", "provider_id", "auto_content_rule_id"], name: "index_on_pulled_board_items_auto_content_rule_id_unique", unique: true, using: :btree
    t.index ["board_id", "provider_name", "provider_id"], name: "index_pulled_board_items_on_board_provider_name_and_provider", unique: true, using: :btree
    t.index ["board_id", "provider_name", "status"], name: "index_pulled_board_items_on_board_provider_and_status", using: :btree
    t.index ["board_id"], name: "index_pulled_board_items_on_board_id", using: :btree
    t.index ["image_url"], name: "index_pulled_board_items_on_image_url", using: :btree
    t.index ["member_id"], name: "index_pulled_board_items_on_member_id", using: :btree
    t.index ["provider_name", "provider_id"], name: "index_pulled_board_items_on_provider_name_and_provider_id", using: :btree
    t.index ["provider_name"], name: "index_pulled_board_items_on_provider_name", using: :btree
    t.index ["source_url"], name: "index_pulled_board_items_on_source_url", using: :btree
    t.index ["tags"], name: "index_pulled_board_items_on_tags", using: :gin
  end

  create_table "redirects", force: :cascade do |t|
    t.string "from_domain", limit: 255, null: false
    t.string "to_domain",   limit: 255, null: false
    t.index ["from_domain"], name: "index_redirects_on_from_domain", unique: true, using: :btree
  end

  create_table "shares", force: :cascade do |t|
    t.text     "message"
    t.string   "share_type",                   limit: 255,                          null: false
    t.integer  "member_id",                                                         null: false
    t.integer  "board_item_id",                                                     null: false
    t.string   "status",                       limit: 255, default: "auth_pending", null: false
    t.text     "link"
    t.text     "picture"
    t.string   "name",                         limit: 255
    t.text     "description"
    t.string   "third_party_id",               limit: 255
    t.string   "oauth2_token",                 limit: 255
    t.integer  "num_likes",                                default: 0,              null: false
    t.integer  "num_comments",                             default: 0,              null: false
    t.integer  "num_shares",                               default: 0,              null: false
    t.integer  "publisher_oauth_token_id"
    t.datetime "scheduled_at"
    t.string   "format",                       limit: 255,                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bitly_user_hash",              limit: 255
    t.string   "schedule_type",                limit: 255, default: "now",          null: false
    t.integer  "delayed_job_id"
    t.hstore   "options",                                  default: {},             null: false
    t.string   "provider_id"
    t.datetime "social_statistics_updated_at"
    t.index ["board_item_id"], name: "index_shares_on_board_item_id", using: :btree
    t.index ["member_id", "board_item_id"], name: "index_shares_on_member_id_and_board_item_id", using: :btree
    t.index ["member_id", "status"], name: "index_shares_on_member_id_and_status", using: :btree
    t.index ["member_id"], name: "index_shares_on_member_id", using: :btree
    t.index ["num_comments"], name: "index_shares_on_num_comments", using: :btree
    t.index ["num_likes"], name: "index_shares_on_num_likes", using: :btree
    t.index ["num_shares"], name: "index_shares_on_num_shares", using: :btree
    t.index ["publisher_oauth_token_id"], name: "index_shares_on_publisher_oauth_token_id", using: :btree
    t.index ["status", "scheduled_at"], name: "index_shares_on_status_and_scheduled_at", using: :btree
  end

  create_table "site_categories", force: :cascade do |t|
    t.string   "name",            limit: 255,                 null: false
    t.string   "domain",          limit: 255,                 null: false
    t.text     "description"
    t.boolean  "visible",                     default: false, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.text     "header_html"
    t.text     "footer_html"
    t.text     "custom_css"
    t.string   "cover_image_uid", limit: 255
    t.index ["domain", "visible"], name: "index_site_categories_on_domain_and_visible", using: :btree
    t.index ["domain"], name: "index_site_categories_on_domain", unique: true, using: :btree
  end

  create_table "site_designs", force: :cascade do |t|
    t.integer  "site_id",                                   null: false
    t.text     "description"
    t.text     "header_html"
    t.text     "custom_css"
    t.text     "footer_html"
    t.text     "like_gate_html"
    t.text     "widget_css"
    t.text     "devise_css"
    t.text     "mobile_header_html"
    t.text     "mobile_footer_html"
    t.text     "email_header_html"
    t.text     "email_footer_html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "request_uploader_location", default: false
    t.text     "content_hub_html"
    t.index ["site_id"], name: "index_site_designs_on_site_id", unique: true, using: :btree
  end

  create_table "site_pages", force: :cascade do |t|
    t.integer  "site_id",                                 null: false
    t.string   "title"
    t.text     "content",                                 null: false
    t.string   "route",                                   null: false
    t.string   "mime_type",         default: "text/html", null: false
    t.boolean  "use_custom_design", default: true,        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["site_id", "route"], name: "index_site_pages_on_site_id_and_route", unique: true, using: :btree
    t.index ["site_id"], name: "index_site_pages_on_site_id", using: :btree
  end

  create_table "site_permission_messages", force: :cascade do |t|
    t.integer  "site_id",                     null: false
    t.text     "default_message"
    t.string   "twitter_message", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vine_message",    limit: 120
    t.index ["site_id"], name: "index_site_permission_messages_on_site_id", unique: true, using: :btree
  end

  create_table "site_providers", force: :cascade do |t|
    t.string   "type",                          limit: 255,              null: false
    t.integer  "site_id",                                                null: false
    t.hstore   "options",                                   default: {}, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_username",              limit: 255
    t.text     "whitelist_accounts",                        default: "", null: false
    t.text     "encrypted_account_password"
    t.string   "encrypted_account_password_iv"
    t.index ["site_id", "type"], name: "index_site_providers_on_site_id_and_type", unique: true, using: :btree
  end

  create_table "site_translations", force: :cascade do |t|
    t.integer  "site_id",                null: false
    t.string   "locale",     limit: 255, null: false
    t.string   "key",        limit: 255, null: false
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["site_id", "locale", "key"], name: "index_site_translations_on_site_id_and_locale_and_key", unique: true, using: :btree
  end

  create_table "site_urls", force: :cascade do |t|
    t.integer  "site_id",    null: false
    t.string   "key",        null: false
    t.string   "value",      null: false
    t.string   "slug",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["site_id", "key"], name: "index_site_urls_on_site_id_and_key", unique: true, using: :btree
    t.index ["site_id"], name: "index_site_urls_on_site_id", using: :btree
    t.index ["slug"], name: "index_site_urls_on_slug", unique: true, using: :btree
  end

  create_table "sites", force: :cascade do |t|
    t.string   "name",                                    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_likes",                                           default: 0,             null: false
    t.integer  "num_complaints",                                      default: 0,             null: false
    t.string   "slug",                                    limit: 255
    t.string   "thumbnail_image_uid",                     limit: 255
    t.string   "facebook_page_id",                        limit: 255
    t.string   "locale",                                  limit: 255, default: "en",          null: false
    t.string   "logo_uid",                                limit: 255
    t.string   "encrypted_password",                      limit: 255
    t.string   "domain",                                  limit: 255,                         null: false
    t.string   "custom_media_board_menu",                 limit: 255
    t.integer  "site_category_id"
    t.string   "parent_site_url",                         limit: 255
    t.string   "subdomain",                               limit: 255,                         null: false
    t.text     "keywords"
    t.string   "google_analytics_key",                    limit: 255
    t.integer  "num_shares",                                          default: 0,             null: false
    t.integer  "num_comments",                                        default: 0,             null: false
    t.integer  "max_num_boards",                                      default: 20,            null: false
    t.bigint   "max_storage_bytes",                                   default: 0
    t.bigint   "total_storage_bytes",                                 default: 0
    t.boolean  "sales_site",                                          default: false,         null: false
    t.integer  "monthly_payment",                                     default: 0,             null: false
    t.string   "status",                                  limit: 255, default: "active",      null: false
    t.text     "authorized_ips"
    t.text     "feature_flags",                                                                            array: true
    t.string   "mobile_bg_image_uid",                     limit: 255
    t.string   "favicon_url",                             limit: 255
    t.string   "page_title_suffix",                       limit: 255
    t.boolean  "send_update_emails",                                  default: true,          null: false
    t.integer  "pull_from_timeout",                                   default: 60,            null: false
    t.boolean  "send_manager_status_mails",                           default: true,          null: false
    t.string   "reply_address",                           limit: 255
    t.string   "timezone",                                limit: 255
    t.boolean  "redirect_www",                                        default: true,          null: false
    t.integer  "max_num_auto_content_rule_items",                     default: 10,            null: false
    t.boolean  "universal_analytics",                                 default: false,         null: false
    t.string   "analytics_domain",                        limit: 255
    t.boolean  "subdomain_tracking",                                  default: false,         null: false
    t.boolean  "opt_in_by_default",                                   default: true
    t.string   "watch_text",                              limit: 255
    t.boolean  "redirect_to_custom_domain",                           default: true,          null: false
    t.boolean  "request_permission_from_social_networks",             default: false,         null: false
    t.string   "terms_url",                               limit: 255
    t.string   "privacy_policy_url",                      limit: 255
    t.string   "domain_path_prefix",                      limit: 255
    t.string   "currency",                                limit: 255
    t.datetime "design_updated_at"
    t.string   "measurement_unit",                        limit: 255, default: "km",          null: false
    t.integer  "max_num_auto_moderation_rules",                       default: 5,             null: false
    t.boolean  "social_login_disabled",                               default: false,         null: false
    t.string   "billing_country",                                     default: "nz",          null: false
    t.boolean  "voting_once_per_day",                                 default: false,         null: false
    t.datetime "learnset_uploaded_at"
    t.text     "product_domain_whitelist",                                                                 array: true
    t.boolean  "direct_thumbnail_image_uid",                          default: false,         null: false
    t.boolean  "direct_logo_uid",                                     default: false,         null: false
    t.boolean  "direct_mobile_bg_image_uid",                          default: false,         null: false
    t.boolean  "enable_search_indexing",                              default: false,         null: false
    t.integer  "max_num_auto_moderation_entries",                     default: 100,           null: false
    t.string   "business_category",                       limit: 255, default: "other",       null: false
    t.string   "lead_source",                             limit: 255, default: "other",       null: false
    t.integer  "setup_payment",                                       default: 0,             null: false
    t.datetime "disabled_at"
    t.integer  "company_health",                                      default: 3,             null: false
    t.string   "chartmogul_uid"
    t.string   "plan",                                                default: "promotional", null: false
    t.datetime "chartmogul_updated_at"
    t.hstore   "balanced_options",                                    default: {},            null: false
    t.hstore   "options",                                             default: {},            null: false
    t.text     "seeds",                                               default: [],                         array: true
    t.integer  "max_num_seeds",                                       default: 10,            null: false
    t.integer  "guest_browser_cache_seconds"
    t.integer  "max_num_auto_content_rules",                          default: 20,            null: false
    t.index ["domain"], name: "index_sites_on_domain", unique: true, using: :btree
    t.index ["facebook_page_id"], name: "index_sites_on_facebook_id", using: :btree
    t.index ["locale"], name: "index_sites_on_locale", using: :btree
    t.index ["num_comments"], name: "index_sites_on_num_comments", using: :btree
    t.index ["num_shares"], name: "index_sites_on_num_shares", using: :btree
    t.index ["site_category_id"], name: "index_sites_on_site_category_id", using: :btree
    t.index ["slug"], name: "index_sites_on_slug", unique: true, using: :btree
    t.index ["status"], name: "index_sites_on_status", using: :btree
    t.index ["subdomain"], name: "index_sites_on_subdomain", unique: true, using: :btree
  end

  create_table "social_widgets", force: :cascade do |t|
    t.hstore   "options",                default: {}, null: false
    t.string   "name",       limit: 255,              null: false
    t.integer  "site_id",                             null: false
    t.string   "type",       limit: 255,              null: false
    t.string   "slug",       limit: 255,              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["site_id"], name: "index_social_widgets_on_site_id", using: :btree
    t.index ["slug"], name: "index_social_widgets_on_slug", unique: true, using: :btree
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, force: :cascade do |t|
    t.string  "auth_name", limit: 256
    t.integer "auth_srid"
    t.string  "srtext",    limit: 2048
    t.string  "proj4text", limit: 2048
  end

  create_table "squad_invites", force: :cascade do |t|
    t.string   "slug",                            null: false
    t.integer  "site_id",                         null: false
    t.string   "email",                           null: false
    t.string   "invite_code",                     null: false
    t.string   "status",      default: "pending", null: false
    t.integer  "squad_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
    t.index ["invite_code"], name: "index_squad_invites_on_invite_code", unique: true, using: :btree
    t.index ["member_id"], name: "index_squad_invites_on_member_id", using: :btree
    t.index ["site_id"], name: "index_squad_invites_on_site_id", using: :btree
    t.index ["slug"], name: "index_squad_invites_on_slug", unique: true, using: :btree
    t.index ["squad_id"], name: "index_squad_invites_on_squad_id", using: :btree
  end

  create_table "squad_tasks", force: :cascade do |t|
    t.string   "slug",                                 null: false
    t.string   "name",                                 null: false
    t.text     "description",                          null: false
    t.string   "status",           default: "pending", null: false
    t.integer  "board_id",                             null: false
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "item_type",        default: "photo",   null: false
    t.text     "tags",                                              array: true
    t.integer  "site_id",                              null: false
    t.integer  "num_contributors", default: 0,         null: false
    t.integer  "num_submissions",  default: 0,         null: false
    t.integer  "num_comments",     default: 0,         null: false
    t.integer  "num_complaints",   default: 0,         null: false
    t.integer  "num_likes",        default: 0,         null: false
    t.integer  "num_shares",       default: 0,         null: false
    t.index ["board_id"], name: "index_squad_tasks_on_board_id", using: :btree
    t.index ["product_id"], name: "index_squad_tasks_on_product_id", using: :btree
    t.index ["site_id", "name"], name: "index_squad_tasks_on_site_id_and_name", unique: true, using: :btree
    t.index ["site_id"], name: "index_squad_tasks_on_site_id", using: :btree
    t.index ["slug"], name: "index_squad_tasks_on_slug", unique: true, using: :btree
  end

  create_table "squad_tasks_squads", id: false, force: :cascade do |t|
    t.integer "squad_task_id", null: false
    t.integer "squad_id",      null: false
    t.index ["squad_id"], name: "index_squad_tasks_squads_on_squad_id", using: :btree
    t.index ["squad_task_id", "squad_id"], name: "index_squad_tasks_squads_on_squad_task_id_and_squad_id", unique: true, using: :btree
    t.index ["squad_task_id"], name: "index_squad_tasks_squads_on_squad_task_id", using: :btree
  end

  create_table "squads", force: :cascade do |t|
    t.integer  "site_id",                                                 null: false
    t.string   "slug",                                                    null: false
    t.string   "name",                                                    null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_share",                            default: true,     null: false
    t.boolean  "allow_public_signup",                  default: false,    null: false
    t.integer  "default_upload_board_id",                                 null: false
    t.string   "image_uid",               limit: 2048
    t.integer  "num_members",                          default: 0,        null: false
    t.integer  "num_active_squad_tasks",               default: 0,        null: false
    t.integer  "num_comments",                         default: 0,        null: false
    t.integer  "num_complaints",                       default: 0,        null: false
    t.integer  "num_likes",                            default: 0,        null: false
    t.integer  "num_shares",                           default: 0,        null: false
    t.string   "status",                               default: "active", null: false
    t.index ["default_upload_board_id"], name: "index_squads_on_default_upload_board_id", using: :btree
    t.index ["name", "site_id"], name: "index_squads_on_name_and_site_id", unique: true, using: :btree
    t.index ["site_id"], name: "index_squads_on_site_id", using: :btree
    t.index ["slug"], name: "index_squads_on_slug", unique: true, using: :btree
  end

  create_table "translations", force: :cascade do |t|
    t.integer  "source_id",               null: false
    t.string   "source_type", limit: 255, null: false
    t.string   "locale",      limit: 255, null: false
    t.string   "key",         limit: 255, null: false
    t.text     "translation",             null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["source_id", "source_type", "locale", "key"], name: "index_translations_on_all_keys", unique: true, using: :btree
    t.index ["source_id", "source_type"], name: "index_translations_on_source_id_and_source_type", using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255, null: false
    t.integer  "item_id",                    null: false
    t.string   "event",          limit: 255, null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object"
    t.text     "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

end
