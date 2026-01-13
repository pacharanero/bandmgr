class SetlistSongsController < ApplicationController
  before_action :require_account
  before_action :set_setlist

  def create
    authorize @setlist, :update?

    song = @setlist.band.songs.find_by(id: params[:song_id])
    if song.nil?
      respond_to do |format|
        format.html { redirect_to @setlist, alert: "Song must belong to the same band." }
        format.json { render json: { error: "wrong_band" }, status: :unprocessable_entity }
      end
      return
    end
    if @setlist.setlist_songs.exists?(song_id: song.id)
      respond_to do |format|
        format.html { redirect_to @setlist, alert: "That song is already in the setlist." }
        format.json { render json: { error: "already_added" }, status: :unprocessable_entity }
      end
      return
    end

    position = @setlist.setlist_songs.maximum(:position).to_i + 1
    @setlist.setlist_songs.create!(song: song, position: position)

    respond_to do |format|
      format.html { redirect_to @setlist, notice: "Song added to setlist." }
      format.json { render json: { status: "ok" } }
    end
  end

  def destroy
    authorize @setlist, :update?
    setlist_song = @setlist.setlist_songs.find(params[:id])
    setlist_song.destroy
    redirect_to @setlist, notice: "Song removed from setlist."
  end

  def reorder
    authorize @setlist, :update?
    order = params[:order].to_a.map(&:to_i)
    return head :bad_request if order.empty?

    setlist_song_ids = @setlist.setlist_songs.where(id: order).pluck(:id)
    return head :unprocessable_entity if setlist_song_ids.sort != order.sort

    update_positions(order)
    head :ok
  end

  private
    def set_setlist
      @setlist = policy_scope(Setlist).find(params[:setlist_id])
    end

    def update_positions(order)
      case_statements = order.each_with_index.map { |id, index| "WHEN #{id} THEN #{index + 1}" }.join(" ")
      SetlistSong.where(id: order).update_all("position = CASE id #{case_statements} END")
    end
end
