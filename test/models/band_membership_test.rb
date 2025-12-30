require "test_helper"

class BandMembershipTest < ActiveSupport::TestCase
  test "defaults to member role" do
    band_membership = BandMembership.new(band: bands(:one), user: users(:one))

    assert_equal "member", band_membership.role
  end

  test "enforces unique user per band" do
    band_membership = BandMembership.new(band: bands(:one), user: users(:one), role: :read_only)

    assert_not band_membership.valid?
    assert_includes band_membership.errors[:user_id], "has already been taken"
  end
end
