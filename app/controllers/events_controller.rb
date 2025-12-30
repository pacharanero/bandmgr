class EventsController < ApplicationController
  before_action :require_account
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = policy_scope(Event).joins(:band).where(bands: { account_id: current_account.id }).order(starts_at: :asc)
  end

  def show
    authorize @event
  end

  def new
    @event = Event.new
    authorize @event
    load_bands
  end

  def create
    @event = Event.new(event_params)
    authorize @event

    if @event.save
      redirect_to @event, notice: "Event created."
    else
      load_bands
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @event
    load_bands
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: "Event updated."
    else
      load_bands
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to events_path, notice: "Event deleted."
  end

  private
    def set_event
      @event = policy_scope(Event).find(params[:id])
    end

    def event_params
      params.require(:event).permit(:band_id, :kind, :starts_at, :venue, :notes)
    end

    def load_bands
      @bands = current_account.bands.order(:name)
    end
end
