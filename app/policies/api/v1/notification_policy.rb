class Api::V1::NotificationPolicy < Api::V1::Policy
  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.where(user_id: user.id)
    end
  end

  def update?
    user.present?
  end
end
