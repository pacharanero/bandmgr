class AccountPolicy < ApplicationPolicy
  def show?
    member?
  end

  def create?
    user.present?
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  def member?
    user && record.memberships.exists?(user_id: user.id)
  end

  def owner_or_admin?
    user && record.memberships.where(user_id: user.id, role: %i[owner admin]).exists?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.joins(:memberships).where(memberships: { user_id: user.id }).distinct
    end
  end
end
