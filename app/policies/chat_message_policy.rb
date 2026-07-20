class ChatMessagePolicy < ApplicationPolicy
  def show?
    channel_access?
  end

  def create?
    channel_access?
  end

  def react?
    channel_access?
  end

  class Scope < Scope
    def resolve
      channel_ids = ChatChannelPolicy::Scope.new(user, ChatChannel).resolve.select(:id)
      scope.where(chat_channel_id: channel_ids)
    end
  end

  private
    def channel_access?
      ChatChannelPolicy.new(user, record.chat_channel).show?
    end
end
