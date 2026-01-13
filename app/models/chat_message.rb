class ChatMessage < ApplicationRecord
  belongs_to :chat_channel
  belongs_to :user
  belongs_to :parent, class_name: "ChatMessage", optional: true

  validates :body, presence: true
end
