class Api::V1::NotificationsController < Api::V1::BaseController
  after_action :verify_authorized

  def index
    authorize Notification
    @notifications = policy_scope(Notification).where(user: current_user).order(:created_at: :desc).limit(50)
    render json: @notifications
  end

  def update
    @notification = current_user.notifications.find(params[:id])
    authorize @notification

    if @notification.update(read: true)
      render json: @notification
    else
      render json: { errors: @notification.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
