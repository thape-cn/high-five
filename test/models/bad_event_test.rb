require "test_helper"

class BadEventTest < ActiveSupport::TestCase
  test "Bad one has 1 user" do
    bad_one = bad_events(:bad_one)
    assert bad_one.valid?
    assert_equal bad_one.users.count, 1
    assert_equal bad_one.users_count, 1
  end

  test "Worse two has 2 users" do
    worse_two = bad_events(:worse_two)
    assert worse_two.valid?
    assert_equal worse_two.users.count, 2
    assert_equal worse_two.users_count, 2
  end
end
