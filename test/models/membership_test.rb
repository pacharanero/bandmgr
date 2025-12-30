require "test_helper"

class MembershipTest < ActiveSupport::TestCase
  test "defaults to member role" do
    membership = Membership.new(account: accounts(:one), user: users(:one))

    assert_equal "member", membership.role
  end

  test "enforces unique user per account" do
    membership = Membership.new(account: accounts(:one), user: users(:one), role: :admin)

    assert_not membership.valid?
    assert_includes membership.errors[:user_id], "has already been taken"
  end
end
