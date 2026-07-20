class NotificationsController < ApplicationController
  before_action :require_account
  after_action :verify_policy_scoped, only: :index

  def index
    authorize Notification
    @notifications = policy_scope(Notification).includes(:actor, :notifiable).order(created_at: :desc)
  end
end
