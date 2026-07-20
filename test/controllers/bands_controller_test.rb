require "test_helper"

class BandsControllerTest < ActionDispatch::IntegrationTest
  test "redirects to account setup when no account" do
    user = User.create!(email_address: "loner@example.com", password: "password", password_confirmation: "password")
    sign_in_as user

    get bands_path
    assert_redirected_to new_account_path
  end

  test "shows bands index for account member" do
    sign_in_as users(:one)

    get bands_path
    assert_response :success
  end

  test "creates a band and membership" do
    sign_in_as users(:one)

    assert_difference("Band.count", 1) do
      assert_difference("BandMembership.count", 1) do
        post bands_path, params: { band: { name: "New Band", description: "Test band" } }
      end
    end

    band = Band.last
    membership = BandMembership.last

    assert_equal band, membership.band
    assert_equal users(:one), membership.user
    assert_equal "band_admin", membership.role
    assert_predicate membership, :accepted?
  end

  test "updates public website settings for a band admin" do
    sign_in_as users(:one)

    patch band_path(bands(:one)), params: { band: { public_site_enabled: true, public_domain: "example-band.test", public_contact_email: "booking@example.test", merch_url: "https://shop.example.test", public_site_markdown: "# {{ bandName }}" } }

    assert_redirected_to bands(:one)
    band = bands(:one).reload
    assert_predicate band, :public_site_enabled?
    assert_equal "example-band.test", band.public_domain
  end
end
