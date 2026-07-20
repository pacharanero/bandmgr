class PushNotificationJob < ApplicationJob
  queue_as :notifications

  discard_on ActiveJob::DeserializationError

  def perform(notification)
    return unless vapid_configured?

    notification.user.push_subscriptions.find_each do |subscription|
      send_push(subscription, notification)
    rescue WebPush::ExpiredSubscription, WebPush::InvalidSubscription
      subscription.destroy!
    end
  end

  private

    def send_push(subscription, notification)
      WebPush.payload_send(
        message: payload_for(notification).to_json,
        endpoint: subscription.endpoint,
        p256dh: subscription.p256dh,
        auth: subscription.auth,
        ttl: 300,
        urgency: "normal",
        vapid: {
          subject: ENV.fetch("VAPID_SUBJECT"),
          public_key: ENV.fetch("VAPID_PUBLIC_KEY"),
          private_key: ENV.fetch("VAPID_PRIVATE_KEY")
        }
      )
    end

    def payload_for(notification)
      message = notification.notifiable
      {
        title: "Bandmgr",
        body: "New reply in band chat",
        url: Rails.application.routes.url_helpers.chat_band_path(message.chat_channel.band, channel_id: message.chat_channel_id)
      }
    end

    def vapid_configured?
      ENV["VAPID_SUBJECT"].present? && ENV["VAPID_PUBLIC_KEY"].present? && ENV["VAPID_PRIVATE_KEY"].present?
    end
end
