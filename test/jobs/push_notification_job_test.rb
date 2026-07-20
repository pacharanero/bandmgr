require "test_helper"

class PushNotificationJobTest < ActiveJob::TestCase
  test "sends a generic push payload for a chat reply" do
    channel = ChatChannel.create!(band: bands(:one), name: "General", kind: :general)
    message = channel.chat_messages.create!(user: users(:one), body: "Private message text")
    notification = Notification.create!(user: users(:one), actor: users(:two), notifiable: message, kind: :chat_reply)
    subscription = PushSubscription.create!(
      user: users(:one),
      endpoint: "https://push.example.test/subscription",
      p256dh: "public-key",
      auth: "auth-token",
      last_used_at: Time.current
    )
    payload = nil
    original_payload_send = WebPush.method(:payload_send)

    with_vapid do
      WebPush.define_singleton_method(:payload_send) { |**options| payload = options }
      PushNotificationJob.perform_now(notification)
    end

    assert_equal subscription.endpoint, payload.fetch(:endpoint)
    assert_equal "New reply in band chat", JSON.parse(payload.fetch(:message)).fetch("body")
    assert_not_includes payload.fetch(:message), message.body
  ensure
    WebPush.define_singleton_method(:payload_send, original_payload_send) if original_payload_send
  end

  private

    def with_vapid
      keys = %w[VAPID_SUBJECT VAPID_PUBLIC_KEY VAPID_PRIVATE_KEY]
      original = keys.to_h { |key| [ key, ENV[key] ] }
      ENV["VAPID_SUBJECT"] = "mailto:admin@example.test"
      ENV["VAPID_PUBLIC_KEY"] = "public-key"
      ENV["VAPID_PRIVATE_KEY"] = "private-key"
      yield
    ensure
      original.each { |key, value| ENV[key] = value }
    end
end
