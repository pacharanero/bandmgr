class PushSubscriptionsController < ApplicationController
  before_action :require_account
  before_action :set_push_subscription, only: :destroy

  def create
    @push_subscription = PushSubscription.find_or_initialize_by(endpoint: push_subscription_params[:endpoint])
    @push_subscription.user = current_user
    authorize @push_subscription

    if @push_subscription.update(push_subscription_params.merge(last_used_at: Time.current))
      head :created
    else
      render json: { errors: @push_subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @push_subscription
    @push_subscription.destroy
    head :no_content
  end

  private

    def set_push_subscription
      @push_subscription = policy_scope(PushSubscription).find(params[:id])
    end

    def push_subscription_params
      params.require(:push_subscription).permit(:endpoint, :p256dh, :auth)
    end
end
