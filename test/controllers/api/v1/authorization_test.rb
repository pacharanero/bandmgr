require "test_helper"

# Regression coverage for API authorization boundaries (R5).
#
# These guard two classes of bug found while hardening the API:
#   1. A read/write/delete permission scope must HALT a mutating action before
#      it runs. A read-only key previously rendered a 403 but still executed the
#      mutation and then raised DoubleRenderError (500).
#   2. An API key must never reach another account's records.
class Api::V1::AuthorizationTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)          # account one, band one (band_admin)
    @band = bands(:one)
    @song = songs(:one)          # account one
    @event = events(:one)        # band one
    @other_song = songs(:two)    # account two
    @other_band = bands(:two)    # account two
  end

  def auth(key)
    { "Authorization" => "Bearer #{key.token}" }
  end

  # --- Permission-scope enforcement halts mutations ---------------------------

  test "read-only key cannot update a song and does not mutate it" do
    key = ApiKey.create!(user: @user, name: "Read only", scopes: "read")
    original = @song.title

    patch api_v1_song_path(@song), params: { song: { title: "Hacked" } }, headers: auth(key)

    assert_response :forbidden
    assert_equal original, @song.reload.title
  end

  test "read-only key cannot delete a song" do
    key = ApiKey.create!(user: @user, name: "Read only", scopes: "read")

    assert_no_difference("Song.count") do
      delete api_v1_song_path(@song), headers: auth(key)
    end

    assert_response :forbidden
  end

  test "write key without delete scope cannot delete a song" do
    key = ApiKey.create!(user: @user, name: "No delete", scopes: "read,write")

    assert_no_difference("Song.count") do
      delete api_v1_song_path(@song), headers: auth(key)
    end

    assert_response :forbidden
  end

  test "read-only key cannot delete an event" do
    key = ApiKey.create!(user: @user, name: "Read only", scopes: "read")

    assert_no_difference("Event.count") do
      delete api_v1_event_path(@event), headers: auth(key)
    end

    assert_response :forbidden
  end

  test "write key can update a song (permission halt does not over-block)" do
    key = ApiKey.create!(user: @user, name: "Writer", scopes: "read,write")

    patch api_v1_song_path(@song), params: { song: { title: "Legit update" } }, headers: auth(key)

    assert_response :success
    assert_equal "Legit update", @song.reload.title
  end

  # --- Cross-account isolation ------------------------------------------------

  test "key cannot read a song from another account" do
    key = ApiKey.create!(user: @user, name: "All", scopes: "all")

    get api_v1_song_path(@other_song), headers: auth(key)

    assert_response :not_found
  end

  test "key cannot update a song from another account" do
    key = ApiKey.create!(user: @user, name: "All", scopes: "all")
    original = @other_song.title

    patch api_v1_song_path(@other_song), params: { song: { title: "Hacked" } }, headers: auth(key)

    assert_response :not_found
    assert_equal original, @other_song.reload.title
  end

  test "key cannot delete a band from another account" do
    key = ApiKey.create!(user: @user, name: "All", scopes: "all")

    assert_no_difference("Band.count") do
      delete api_v1_band_path(@other_band), headers: auth(key)
    end

    assert_response :not_found
  end

  # --- Privilege escalation ---------------------------------------------------

  test "non band-admin cannot assign the band_admin role via the API" do
    member = users(:two)                 # member (not band_admin) of band two
    key = ApiKey.create!(user: member, name: "Member writer", scopes: "read,write")

    post api_v1_band_band_memberships_path(@other_band),
      params: { band_membership: { email_address: "newbie@example.com", role: "band_admin" } },
      headers: auth(key)

    assert_response :forbidden
  end
end
