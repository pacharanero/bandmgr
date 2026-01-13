class ChatChannel < ApplicationRecord
  belongs_to :band
  has_many :chat_messages, dependent: :destroy
  has_many :chat_channel_participants, dependent: :destroy
  has_many :users, through: :chat_channel_participants

  enum :kind, { general: 0, gigs: 1, equipment: 2, direct: 3 }, default: :general

  validates :name, presence: true
end
