class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  before_action :set_current_account
  helper_method :current_user, :current_account, :current_account_membership, :preferred_band

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def current_user
      Current.user
    end

    def current_account
      Current.account
    end

    def current_account_membership
      return unless current_user && current_account

      @current_account_membership ||= current_user.memberships.find_by(account_id: current_account.id)
    end

    def set_current_account
      return unless current_user

      Current.account ||= current_user.accounts.first
    end

    def preferred_band(scope = nil)
      return unless current_account

      bands = Array(scope.presence || current_account.bands)
      return bands.first if bands.one?

      default = current_account_membership&.default_band
      return default if default && bands.any? { |band| band.id == default.id }

      nil
    end

    def require_account
      return if current_account

      redirect_to new_account_path, alert: "Create an account to get started."
    end

    def user_not_authorized
      redirect_to root_path, alert: "You do not have access to that page."
    end
end
