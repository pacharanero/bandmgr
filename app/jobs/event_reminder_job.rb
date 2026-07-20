class EventReminderJob < ApplicationJob
  queue_as :default

  retry_on StandardError, wait: 5.seconds, attempts: 3

  def perform
    Event.where(starts_at: Time.current..24.hours.from_now, reminder_sent_at: nil).find_each do |event|
      event.with_lock do
        next if event.reminder_sent_at?

        Notification.create_for(users: event.band.users, actor: nil, notifiable: event, kind: :event_reminder)
        event.update!(reminder_sent_at: Time.current)
      end
    end
  end
end
