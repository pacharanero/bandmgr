class NotificationPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.where(user_id: user.id)
    end
  end
end
