require 'test_helper'

class LineUserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get line_user_index_url
    assert_response :success
  end

end
