class Api::V1::AttachmentPolicy < Api::V1::Policy
  class Scope < Scope
    def resolve
      scope.none
    end
  end

  def create?
    user.present?
  end

  def destroy?
    user.present?
  end
end
