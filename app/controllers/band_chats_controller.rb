class BandChatsController < ApplicationController
  before_action :require_account
  before_action :set_band
  before_action :ensure_default_channels

  def show
    @channels = policy_scope(ChatChannel).where(band: @band).order(:kind, :name)
    @channel = @channels.find_by(id: params[:channel_id]) || @channels.first
    authorize @channel if @channel
    @messages = if @channel
      policy_scope(ChatMessage)
        .where(chat_channel: @channel, parent_id: nil)
        .includes(:user, :chat_message_reactions, replies: [ :user, :chat_message_reactions ])
        .order(created_at: :asc)
    else
      []
    end
    @members = @band.users.where.not(id: current_user.id).order(:email_address)
  end

  private
    def set_band
      @band = policy_scope(Band).find(params[:id])
      authorize @band, :chat?
    end

    def ensure_default_channels
      defaults = { "General" => :general, "Gigs" => :gigs, "Equipment" => :equipment }
      defaults.each do |name, kind|
        @band.chat_channels.find_or_create_by!(name: name, kind: kind)
      end
    end
end
