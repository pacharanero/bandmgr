require "test_helper"

class AuthorizationControllerTest < ActionDispatch::IntegrationTest
  test "redirects an account member without admin privileges from admin" do
    member = User.create!(email_address: "member@example.com", password: "password", password_confirmation: "password")
    Membership.create!(account: accounts(:one), user: member, role: :member)
    sign_in_as member

    get admin_path

    assert_redirected_to root_path
  end

  test "allows an account owner to view admin" do
    sign_in_as users(:one)

    get admin_path

    assert_response :success
  end

  test "scopes account data away from a member of another account" do
    sign_in_as users(:two)

    get song_path(songs(:one))

    assert_response :not_found

    setlist = Setlist.create!(account: accounts(:one), band: bands(:one), title: "Private setlist")
    get setlist_path(setlist)

    assert_response :not_found

    event = Event.create!(band: bands(:one), kind: :gig, starts_at: Time.current, venue: "Private venue")
    get event_path(event)

    assert_response :not_found
  end

  test "does not attach a setlist from another band to an event" do
    other_band = Band.create!(account: accounts(:one), name: "Other Band")
    other_setlist = Setlist.create!(account: accounts(:one), band: other_band, title: "Other setlist")
    sign_in_as users(:one)

    post events_path, params: {
      event: {
        band_id: bands(:one).id,
        kind: "gig",
        starts_at: "2026-08-13T19:30",
        venue: "Test Venue",
        setlist_ids: [ other_setlist.id ]
      }
    }

    assert_redirected_to event_path(Event.last)
    assert_empty Event.last.setlists
  end

  test "attaches setlists from the selected event band" do
    setlist = Setlist.create!(account: accounts(:one), band: bands(:one), title: "Event setlist")
    sign_in_as users(:one)

    post events_path, params: {
      event: {
        band_id: bands(:one).id,
        kind: "gig",
        starts_at: "2026-08-13T19:30",
        venue: "Test Venue",
        setlist_ids: [ setlist.id ]
      }
    }

    assert_equal [ setlist ], Event.last.setlists.to_a
  end

  test "allows public session and registration endpoints" do
    get new_session_path
    assert_response :success

    get new_registration_path
    assert_response :success
  end

  test "emits a nonce-based content security policy" do
    sign_in_as users(:one)

    get bands_path

    assert_response :success
    assert_match(/script-src 'self' 'nonce-/, response.headers.fetch("Content-Security-Policy"))
    assert_select "script[nonce]", minimum: 1
  end
end
