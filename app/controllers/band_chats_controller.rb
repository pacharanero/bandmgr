class BandChatsController < ApplicationController
  before_action :require_account
  before_action :set_band
  before_action :ensure_default_channels

  def show
    @channels = @band.chat_channels.order(:kind, :name)
    @channel = @channels.find_by(id: params[:channel_id]) || @channels.first
    @messages = @channel ? @channel.chat_messages.includes(:user).order(created_at: :asc) : []
  end

  private
    def set_band
      @band = policy_scope(Band).find(params[:band_id])
      authorize @band
    end

    def ensure_default_channels
      defaults = { "General" => :general, "Gigs" => :gigs, "Equipment" => :equipment }
      defaults.each do |name, kind|
        @band.chat_channels.find_or_create_by!(name: name, kind: kind)
      end
    end
end
