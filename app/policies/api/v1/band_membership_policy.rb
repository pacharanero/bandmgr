class Api::V1::BandMembershipPolicy < Api::V1::Policy
  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.joins(:band).where(bands: { account_id: user.accounts.pluck(:id) }).distinct
    end
  end

  def create?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present?
  end
end
