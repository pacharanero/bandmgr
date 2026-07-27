class Api::V1::BandsController < Api::V1::BaseController
  before_action :set_band, only: %i[show update destroy]
  after_action :verify_authorized, except: :index

  def index
    authorize Band
    @bands = policy_scope(Band).where(account: current_account)
    render json: @bands
  end

  def show
    authorize @band
    render json: @band
  end

  def create
    @band = current_account.bands.new(band_params)
    authorize @band

    if @band.save
      @band.band_memberships.create_or_find_by!(user: current_user, role: :band_admin) do |m|
        m.invitation_accepted_at = Time.current
      end
      render json: @band, status: :created
    else
      render json: { errors: @band.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @band

    unless @api_key.can?("write")
      return render json: { error: "Forbidden", message: "API key does not have write permission" }, status: :forbidden
    end

    if @band.update(band_params)
      render json: @band
    else
      render json: { errors: @band.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @band

    unless @api_key.can?("delete")
      return render json: { error: "Forbidden", message: "API key does not have delete permission" }, status: :forbidden
    end

    @band.destroy
    head :no_content
  end

  private

    def set_band
      @band = policy_scope(Band).find(params[:id])
    end

    def band_params
      params.require(:band).permit(:name, :description, :public_calendar_enabled, :public_calendar_include_rehearsals)
    end
end
