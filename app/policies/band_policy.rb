class BandPolicy < ApplicationPolicy
  def index?
    account_member?
  end

  def show?
    account_member?
  end

  def create?
    account_admin?
  end

  def update?
    band_admin_or_account_admin?
  end

  def destroy?
    band_admin_or_account_admin?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.joins(account: :memberships).where(memberships: { user_id: user.id }).distinct
    end
  end

  private
    def account_member?
      return false unless user
      return user.memberships.exists? if record.is_a?(Class)

      record.account.memberships.exists?(user_id: user.id)
    end

    def account_admin?
      return false unless user
      return user.memberships.where(role: %i[owner admin]).exists? if record.is_a?(Class)

      record.account.memberships.where(user_id: user.id, role: %i[owner admin]).exists?
    end

    def band_admin_or_account_admin?
      return false unless user

      record.band_memberships.where(user_id: user.id, role: :band_admin).exists? || account_admin?
    end
end
