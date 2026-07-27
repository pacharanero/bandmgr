class Api::V1::ApiKeysController < Api::V1::BaseController
  before_action :set_api_key, only: %i[show update destroy revoke]
  after_action :verify_authorized

  def index
    authorize ApiKey
    @api_keys = policy_scope(ApiKey).where(user: current_user)
    render json: @api_keys
  end

  def show
    authorize @api_key
    render json: @api_key
  end

  def create
    @api_key = current_user.api_keys.new(api_key_params)
    authorize @api_key

    if @api_key.save
      render json: { api_key: @api_key, token: @api_key.token }, status: :created
    else
      render json: { errors: @api_key.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @api_key
    check_api_permission("write")

    if @api_key.update(api_key_params.except(:token))
      render json: @api_key
    else
      render json: { errors: @api_key.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @api_key
    check_api_permission("delete")

    @api_key.destroy
    head :no_content
  end

  def revoke
    authorize @api_key
    check_api_permission("write")

    @api_key.revoke!
    render json: @api_key
  end

  private

    def set_api_key
      @api_key = current_user.api_keys.find(params[:id])
    end

    def api_key_params
      params.require(:api_key).permit(:name, :band_id, :scopes, :description, :expires_at)
    end
end
