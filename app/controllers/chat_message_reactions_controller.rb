class ChatMessageReactionsController < ApplicationController
  before_action :require_account

  def toggle
    message = ChatMessage.find(params[:message_id])
    band = message.chat_channel.band
    unless band.band_memberships.where(user_id: current_user.id).exists?
      redirect_to chat_band_path(band), alert: "You do not have access."
      return
    end

    reaction = message.chat_message_reactions.find_by(user_id: current_user.id, kind: "like")
    if reaction
      reaction.destroy
    else
      message.chat_message_reactions.create!(user: current_user, kind: "like")
    end

    redirect_to chat_band_path(band, channel_id: message.chat_channel_id)
  end
end
