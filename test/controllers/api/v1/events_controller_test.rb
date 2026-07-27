require "test_helper"

class Api::V1::EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @band = bands(:one)
    @event = events(:one)
    @api_key = ApiKey.create!(user: @user, name: "Test Key", scopes: "all")
  end

  test "lists events" do
    get api_v1_events_path, headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_includes response.parsed_body.pluck("id"), @event.id
  end

  test "shows an event" do
    get api_v1_event_path(@event), headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal @event.venue, response.parsed_body["venue"]
  end

  test "creates an event" do
    assert_difference("Event.count", 1) do
      post api_v1_events_path, params: { event: { band_id: @band.id, kind: "gig", starts_at: 1.week.from_now, venue: "Test Venue" } },
        headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :created
  end

  test "updates an event" do
    @api_key.update!(scopes: "read,write")

    patch api_v1_event_path(@event), params: { event: { venue: "Updated Venue" } },
      headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal "Updated Venue", @event.reload.venue
  end

  test "destroys an event" do
    @api_key.update!(scopes: "all")

    assert_difference("Event.count", -1) do
      delete api_v1_event_path(@event), headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :no_content
  end
end
