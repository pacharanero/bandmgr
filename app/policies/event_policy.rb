class EventPolicy < ApplicationPolicy
  def index?
    account_member?
  end

  def show?
    account_member?
  end

  def create?
    account_member?
  end

  def update?
    account_member?
  end

  def destroy?
    account_member?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.joins(band: { account: :memberships }).where(memberships: { user_id: user.id }).distinct
    end
  end

  private
    def account_member?
      return false unless user
      return user.memberships.exists? if record.is_a?(Class)

      return user.memberships.exists? if record.band.nil?

      record.band.account.memberships.exists?(user_id: user.id)
    end
end
