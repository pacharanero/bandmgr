require "test_helper"

class BandMembershipsControllerTest < ActionDispatch::IntegrationTest
  test "band admin can add a member by email" do
    sign_in_as users(:one)

    assert_difference("BandMembership.count", 1) do
      assert_difference("Membership.count", 1) do
        post band_band_memberships_path(bands(:one)), params: {
          band_membership: {
            email_address: users(:two).email_address,
            role: "member"
          }
        }
      end
    end

    assert_redirected_to band_path(bands(:one))
    assert Membership.exists?(account: accounts(:one), user: users(:two))
  end

  test "band admin can update member role" do
    sign_in_as users(:one)

    Membership.create!(account: accounts(:one), user: users(:two), role: :member)
    membership = BandMembership.create!(band: bands(:one), user: users(:two), role: :member)

    patch band_band_membership_path(bands(:one), membership), params: {
      band_membership: { role: "read_only" }
    }

    assert_redirected_to band_path(bands(:one))
    assert_equal "read_only", membership.reload.role
  end

  test "band admin can remove a member" do
    sign_in_as users(:one)

    Membership.create!(account: accounts(:one), user: users(:two), role: :member)
    membership = BandMembership.create!(band: bands(:one), user: users(:two), role: :member)

    assert_difference("BandMembership.count", -1) do
      delete band_band_membership_path(bands(:one), membership)
    end

    assert_redirected_to band_path(bands(:one))
  end

  test "non-admin cannot add a member" do
    user = User.create!(email_address: "member@example.com", password: "password", password_confirmation: "password")
    Membership.create!(account: accounts(:one), user: user, role: :member)
    BandMembership.create!(band: bands(:one), user: user, role: :member)

    sign_in_as user

    assert_no_difference("BandMembership.count") do
      post band_band_memberships_path(bands(:one)), params: {
        band_membership: { email_address: users(:two).email_address, role: "member" }
      }
    end

    assert_redirected_to root_path
  end
end
