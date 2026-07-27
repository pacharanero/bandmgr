class Api::V1::EventsController < Api::V1::BaseController
  before_action :set_event, only: %i[show update destroy]
  after_action :verify_authorized, except: :index

  def index
    authorize Event
    @events = policy_scope(Event).joins(:band).where(bands: { account_id: current_account.id }).order(:starts_at)
    render json: @events
  end

  def show
    authorize @event
    render json: @event
  end

  def create
    @event = Event.new(event_params)
    authorize @event

    if @event.save
      render json: @event, status: :created
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @event
    check_api_permission("write")

    if @event.update(event_params)
      render json: @event
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @event
    check_api_permission("delete")

    @event.destroy
    head :no_content
  end

  private

    def set_event
      @event = policy_scope(Event).find(params[:id])
    end

    def event_params
      params.require(:event).permit(:band_id, :kind, :starts_at, :venue, :notes, setlist_ids: [])
    end
end
