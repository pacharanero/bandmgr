class Api::V1::BandPolicy < Api::V1::Policy
  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.joins(account: :memberships).where(memberships: { user_id: user.id }).distinct
    end
  end

  def create?
    user && record.account.memberships.where(user_id: user.id, role: %i[owner admin]).exists?
  end

  def update?
    band_admin_or_account_admin?
  end

  def destroy?
    band_admin_or_account_admin?
  end

  private

    def band_admin_or_account_admin?
      return false unless user

      record.band_memberships.where(user_id: user.id, role: :band_admin).exists? ||
        record.account.memberships.where(user_id: user.id, role: %i[owner admin]).exists?
    end
end
