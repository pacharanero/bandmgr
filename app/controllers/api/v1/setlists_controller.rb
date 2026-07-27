class Api::V1::SetlistsController < Api::V1::BaseController
  before_action :set_setlist, only: %i[show update destroy]
  after_action :verify_authorized, except: :index

  def index
    authorize Setlist
    @setlists = policy_scope(Setlist).joins(:band).where(bands: { account_id: current_account.id }).order(:title)
    render json: @setlists
  end

  def show
    authorize @setlist
    render json: @setlist
  end

  def create
    @setlist = Setlist.new(setlist_params)
    authorize @setlist

    if @setlist.save
      render json: @setlist, status: :created
    else
      render json: { errors: @setlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @setlist
    check_api_permission("write")

    if @setlist.update(setlist_params)
      render json: @setlist
    else
      render json: { errors: @setlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @setlist
    check_api_permission("delete")

    @setlist.destroy
    head :no_content
  end

  private

    def set_setlist
      @setlist = policy_scope(Setlist).find(params[:id])
    end

    def setlist_params
      params.require(:setlist).permit(:title, :description, :band_id)
    end
end
