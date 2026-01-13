class ChatMessageReaction < ApplicationRecord
  belongs_to :chat_message
  belongs_to :user

  validates :kind, presence: true
end
