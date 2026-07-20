class ChatChannelPolicy < ApplicationPolicy
  def index?
    band_member?
  end

  def show?
    band_member? && (!record.direct? || participant?)
  end

  def create?
    band_member?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope
        .joins(band: :band_memberships)
        .left_joins(:chat_channel_participants)
        .where(band_memberships: { user_id: user.id })
        .where("chat_channels.kind != :direct OR chat_channel_participants.user_id = :user_id", direct: ChatChannel.kinds[:direct], user_id: user.id)
        .distinct
    end
  end

  private
    def band_member?
      user && record.band.band_memberships.exists?(user_id: user.id)
    end

    def participant?
      record.chat_channel_participants.exists?(user_id: user.id)
    end
end
