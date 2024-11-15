require "test_helper"

class GoodEventTest < ActiveSupport::TestCase
  test "Good one has 2 users" do
    good_one = good_events(:good_one)
    assert good_one.valid?
    assert_equal good_one.users.count, 2
    assert_equal good_one.users_count, 2
  end

  test "Good two has 1 user" do
    great_two = good_events(:great_two)
    assert great_two.valid?
    assert_equal great_two.users.count, 1
    assert_equal great_two.users_count, 1
  end
end
