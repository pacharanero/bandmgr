module Api
  module V1
    class Policy < ApplicationPolicy
      class Scope
        attr_reader :user, :scope

        def initialize(user, scope)
          @user = user
          @scope = scope
        end

        def resolve
          scope.none
        end
      end

      def initialize(user, record)
        @user = user
        @record = record
      end

      def index?
        user.present?
      end

      def show?
        user.present?
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
  end
end
