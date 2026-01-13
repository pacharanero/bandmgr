class BandMembershipPolicy < ApplicationPolicy
  def create?
    band_admin?
  end

  def update?
    band_admin?
  end

  def destroy?
    band_admin?
  end

  def resend_invite?
    band_admin?
  end

  private
    def band_admin?
      return false unless user

      band = record.band
      band.band_memberships.where(user_id: user.id, role: :band_admin).exists?
    end
end
