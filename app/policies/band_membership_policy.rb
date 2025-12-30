class BandMembershipPolicy < ApplicationPolicy
  def create?
    band_admin_or_account_admin?
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

      band = record.band
      band.band_memberships.where(user_id: user.id, role: :band_admin).exists? ||
        band.account.memberships.where(user_id: user.id, role: %i[owner admin]).exists?
    end
end
