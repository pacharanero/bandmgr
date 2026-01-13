class EventsController < ApplicationController
  before_action :require_account
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = policy_scope(Event).joins(:band).where(bands: { account_id: current_account.id }).order(starts_at: :asc)
  end

  def calendar
    @month = parse_month(params[:month], params[:year])
    @start_date = @month.beginning_of_month.beginning_of_week(:monday)
    @end_date = @month.end_of_month.end_of_week(:monday)

    events = policy_scope(Event)
      .joins(:band)
      .where(bands: { account_id: current_account.id })
      .where(starts_at: @start_date.beginning_of_day..@end_date.end_of_day)
      .order(starts_at: :asc)

    @events_by_date = events.group_by { |event| event.starts_at.to_date }
  end

  def show
    authorize @event
  end

  def new
    @event = Event.new
    authorize @event
    load_bands
    @event.band ||= @selected_band
    @selected_band = @event.band
    load_setlists
  end

  def create
    load_bands
    band_id = event_params[:band_id].presence || @selected_band&.id
    @event = Event.new(event_params.merge(band_id: band_id))
    authorize @event
    @selected_band = @event.band
    load_setlists

    if @event.save
      assign_setlists
      redirect_to @event, notice: "Event created."
    else
      load_bands
      load_setlists
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @event
    load_bands
    @selected_band ||= @event.band
    load_setlists
  end

  def update
    authorize @event
    @selected_band = @event.band
    load_setlists

    if @event.update(event_params)
      assign_setlists
      redirect_to @event, notice: "Event updated."
    else
      load_bands
      load_setlists
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
      params.require(:event).permit(:band_id, :kind, :starts_at, :venue, :notes, setlist_ids: [], attachments: [])
    end

    def load_bands
      @bands = current_account.bands.order(:name)
      @selected_band = preferred_band(@bands)
    end

    def load_setlists
      @setlists = @selected_band ? @selected_band.setlists.order(:title) : Setlist.none
    end

    def assign_setlists
      return if @event.band.nil?

      ids = Array(params.dig(:event, :setlist_ids)).reject(&:blank?).map(&:to_i).uniq
      @event.setlist_ids = @event.band.setlists.where(id: ids).pluck(:id)
    end

    def parse_month(month_param, year_param)
      year = year_param.to_i
      month = month_param.to_i
      if year.positive? && month.positive?
        Date.new(year, month, 1)
      else
        Date.current.beginning_of_month
      end
    rescue Date::Error
      Date.current.beginning_of_month
    end
end
