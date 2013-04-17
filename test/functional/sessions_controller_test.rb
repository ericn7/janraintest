require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get rpx_token" do
    get :rpx_token
    assert_response :success
  end

end
