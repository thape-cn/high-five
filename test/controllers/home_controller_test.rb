require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get root after sign in" do
    sign_in users(:user_fangzixue)
    get root_url
    assert_response :success
  end

  test "should get root if not sign in" do
    get root_url
    assert_response :success
  end
end
