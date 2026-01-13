class ChatMessage < ApplicationRecord
  belongs_to :chat_channel
  belongs_to :user
  belongs_to :parent, class_name: "ChatMessage", optional: true

  has_many :chat_message_reactions, dependent: :destroy

  validates :body, presence: true
end
