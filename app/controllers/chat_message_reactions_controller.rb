class ChatMessageReactionsController < ApplicationController
  before_action :require_account

  def toggle
    message = policy_scope(ChatMessage).find(params[:message_id])
    authorize message, :react?

    reaction = message.chat_message_reactions.find_by(user_id: current_user.id, kind: "like")
    if reaction
      reaction.destroy
    else
      message.chat_message_reactions.create!(user: current_user, kind: "like")
    end

    redirect_to chat_band_path(message.chat_channel.band, channel_id: message.chat_channel_id)
  end
end
