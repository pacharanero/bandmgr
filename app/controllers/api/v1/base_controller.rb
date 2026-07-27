class Api::V1::BaseController < ApplicationController
  PermissionDenied = Class.new(StandardError)

  skip_before_action :require_authentication
  skip_before_action :verify_authenticity_token
  before_action :authenticate_api_key
  around_action :set_current_api_key
  after_action :mark_api_key_used

  rescue_from Pundit::NotAuthorizedError, with: :api_not_authorized
  rescue_from PermissionDenied, with: :api_permission_denied

  private

    def authenticate_api_key
      token = api_token_from_header
      return unauthorized if token.blank?

      @api_key = ApiKey.active.joins(:user).find_by(token: token)
      return if @api_key.present?

      unauthorized
    end

    def current_user
      @api_key&.user
    end

    def current_account
      @current_account ||= if @api_key&.band
        @api_key.band.account
      else
        current_user&.accounts&.first
      end
    end

    def set_current_api_key
      Current.api_key = @api_key
      yield
    ensure
      Current.api_key = nil
    end

    def mark_api_key_used
      @api_key&.mark_used! if @api_key.present?
    end

    def api_token_from_header
      authorization = request.headers["Authorization"]
      return unless authorization&.start_with?("Bearer ")

      authorization[7..-1]
    end

    def unauthorized
      render json: { error: "Unauthorized", message: "Invalid or expired API key" }, status: :unauthorized
    end

    def api_not_authorized
      render json: { error: "Forbidden", message: "You do not have access to that resource" }, status: :forbidden
    end

    def api_permission_denied(error)
      render json: { error: "Forbidden", message: error.message }, status: :forbidden
    end

    # Raises to guarantee the action halts before any mutation runs. Rescued to a
    # clean 403 by rescue_from PermissionDenied. Never render here: callers invoke
    # this inline without `return`, so rendering would let the mutation proceed.
    def check_api_permission(permission)
      return unless @api_key.present? && !@api_key.can?(permission)

      raise PermissionDenied, "API key does not have #{permission} permission"
    end
end
