require "test_helper"

class EventReminderJobTest < ActiveJob::TestCase
  test "notifies band members once for an event within 24 hours" do
    event = Event.create!(band: bands(:one), kind: :gig, starts_at: 23.hours.from_now, venue: "Tomorrow's venue")

    assert_difference("Notification.count", 1) do
      EventReminderJob.perform_now
    end

    assert_predicate event.reload, :reminder_sent_at?
    assert_equal "event_reminder", Notification.last.kind

    assert_no_difference("Notification.count") do
      EventReminderJob.perform_now
    end
  end
end
