require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "User guochunzhong has 2 record of bad_events" do
    guochunzhong = users(:user_guochunzhong)
    assert guochunzhong.valid?
    assert_equal guochunzhong.bad_events.count, 2
  end

  test "User user_fangzixue has 1 record of bad_events" do
    fangzixue = users(:user_fangzixue)
    assert fangzixue.valid?
    assert_equal fangzixue.bad_events.count, 1
  end

  test "User guochunzhong has 1 record of good_events" do
    guochunzhong = users(:user_guochunzhong)
    assert guochunzhong.valid?
    assert_equal guochunzhong.good_events.count, 1
  end

  test "User user_fangzixue has 2 record of good_events" do
    fangzixue = users(:user_fangzixue)
    assert fangzixue.valid?
    assert_equal fangzixue.good_events.count, 2
  end
end
