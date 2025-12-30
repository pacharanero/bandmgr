require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    get events_path
    assert_redirected_to new_session_path
  end

  test "shows index for account member" do
    sign_in_as users(:one)

    get events_path
    assert_response :success
  end

  test "creates an event" do
    sign_in_as users(:one)

    assert_difference("Event.count", 1) do
      post events_path, params: {
        event: {
          band_id: bands(:one).id,
          kind: "gig",
          starts_at: "2025-12-31T19:30",
          venue: "Test Venue",
          notes: "Soundcheck at 6"
        }
      }
    end

    assert_redirected_to event_path(Event.order(:created_at).last)
  end

  test "updates an event" do
    sign_in_as users(:one)

    patch event_path(events(:one)), params: { event: { venue: "Updated Venue" } }

    assert_redirected_to event_path(events(:one))
    assert_equal "Updated Venue", events(:one).reload.venue
  end

  test "deletes an event" do
    sign_in_as users(:one)

    assert_difference("Event.count", -1) do
      delete event_path(events(:one))
    end

    assert_redirected_to events_path
  end
end
