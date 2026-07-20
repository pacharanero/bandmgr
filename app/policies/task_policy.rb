class TaskPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    band_member?
  end

  def show?
    band_member?
  end

  def update?
    band_member?
  end

  def destroy?
    band_member?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.joins(band: :band_memberships).where(band_memberships: { user_id: user.id }).distinct
    end
  end

  private

    def band_member?
      user && record.band&.band_memberships&.exists?(user_id: user.id)
    end
end
