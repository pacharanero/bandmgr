class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User", optional: true
  belongs_to :notifiable, polymorphic: true

  enum :kind, { task_assigned: 0, comment_added: 1, chat_reply: 2, event_reminder: 3 }, default: :comment_added

  def self.create_for(users:, actor:, notifiable:, kind:)
    Array(users).compact.uniq(&:id).reject { |user| user == actor }.map do |user|
      notification = create!(user: user, actor: actor, notifiable: notifiable, kind: kind)
      PushNotificationJob.perform_later(notification) if notification.chat_reply?
      notification
    end
  end
end
