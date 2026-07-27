class Api::V1::CommentPolicy < Api::V1::Policy
  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.joins(commentable: { band: :account })
        .where(bands: { account_id: user.accounts.pluck(:id) })
        .distinct
    end
  end

  def create?
    user.present?
  end
end
