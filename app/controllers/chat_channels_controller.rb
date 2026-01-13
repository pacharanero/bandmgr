class ChatChannelsController < ApplicationController
  before_action :require_account

  def create
    band = policy_scope(Band).find(params[:band_id])
    authorize band

    recipient = band.users.find_by(id: params[:recipient_id])
    unless recipient
      redirect_to chat_band_path(band), alert: "Select a valid member."
      return
    end

    channel = find_or_create_direct_channel(band, [ current_user, recipient ])
    redirect_to chat_band_path(band, channel_id: channel.id)
  end

  private
    def find_or_create_direct_channel(band, users)
      channel = band.chat_channels.find_by(kind: :direct, name: direct_name(users))
      return channel if channel

      channel = band.chat_channels.create!(name: direct_name(users), kind: :direct)
      users.each { |user| channel.chat_channel_participants.find_or_create_by!(user: user) }
      channel
    end

    def direct_name(users)
      users.map { |user| user.email_address }.sort.join(" & ")
    end
end
