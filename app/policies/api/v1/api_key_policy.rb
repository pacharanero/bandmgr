class Api::V1::ApiKeyPolicy < Api::V1::Policy
  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.where(user: user)
    end
  end

  def create?
    user.present?
  end

  def update?
    user.present? && record.user_id == user.id
  end

  def destroy?
    user.present? && record.user_id == user.id
  end

  def revoke?
    update?
  end
end
