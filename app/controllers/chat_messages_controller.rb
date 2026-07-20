class ChatMessagesController < ApplicationController
  before_action :require_account
  before_action :set_channel

  def create
    @message = @channel.chat_messages.new(message_params.merge(user: current_user))
    authorize @message

    if @message.save
      notify_parent_author
      redirect_to chat_band_path(@channel.band, channel_id: @channel.id), notice: "Message sent."
    else
      redirect_to chat_band_path(@channel.band, channel_id: @channel.id), alert: @message.errors.full_messages.to_sentence
    end
  end

  private

    def set_channel
      @channel = policy_scope(ChatChannel).find(params[:chat_channel_id])
      authorize @channel, :show?
    end

    def message_params
      params.require(:chat_message).permit(:body, :parent_id)
    end

    def notify_parent_author
      return unless @message.parent

      Notification.create_for(users: @message.parent.user, actor: current_user, notifiable: @message, kind: :chat_reply)
    end
end
