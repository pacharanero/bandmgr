class ChatChannelParticipant < ApplicationRecord
  belongs_to :chat_channel
  belongs_to :user
end
