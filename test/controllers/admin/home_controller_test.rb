require "test_helper"

class Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get admin root after sign in" do
    sign_in users(:user_guochunzhong)
    get admin_root_path
    assert_response :success
  end
end
