class PushSubscriptionPolicy < ApplicationPolicy
  def create?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.where(user_id: user.id)
    end
  end
end
