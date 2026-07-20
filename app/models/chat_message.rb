class ChatMessage < ApplicationRecord
  belongs_to :chat_channel
  belongs_to :user
  belongs_to :parent, class_name: "ChatMessage", optional: true

  has_many :chat_message_reactions, dependent: :destroy
  has_many :replies, class_name: "ChatMessage", foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :body, presence: true
  validate :parent_belongs_to_same_channel
  validate :parent_is_root_message

  private

    def parent_belongs_to_same_channel
      return if parent.nil? || parent.chat_channel_id == chat_channel_id

      errors.add(:parent, "must belong to the same channel")
    end

    def parent_is_root_message
      return if parent.nil? || parent.parent_id.nil?

      errors.add(:parent, "must be a top-level message")
    end
end
