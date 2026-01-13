class SetlistSongsController < ApplicationController
  before_action :require_account
  before_action :set_setlist
  require "set"

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

  def bulk_create
    authorize @setlist, :update?
    song_ids = Array(params[:song_ids]).map(&:to_i).uniq
    if song_ids.empty?
      redirect_to @setlist, alert: "Select at least one song to add."
      return
    end

    existing_ids = @setlist.setlist_songs.where(song_id: song_ids).pluck(:song_id).to_set
    position = @setlist.setlist_songs.maximum(:position).to_i
    created = 0

    @setlist.band.songs.where(id: song_ids).find_each do |song|
      next if existing_ids.include?(song.id)

      position += 1
      @setlist.setlist_songs.create!(song: song, position: position)
      created += 1
    end

    redirect_to @setlist, notice: "Added #{created} songs."
  end

  def destroy
    authorize @setlist, :update?
    setlist_song = @setlist.setlist_songs.find(params[:id])
    setlist_song.destroy
    redirect_to @setlist, notice: "Song removed from setlist."
  end

  def bulk_destroy
    authorize @setlist, :update?
    ids = Array(params[:setlist_song_ids]).map(&:to_i).uniq
    if ids.empty?
      redirect_to @setlist, alert: "Select at least one song to remove."
      return
    end

    @setlist.setlist_songs.where(id: ids).destroy_all
    redirect_to @setlist, notice: "Removed #{ids.size} songs."
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
      pairs = order.map.with_index { |id, index| [ id, index + 1 ] }
      case_sql = pairs.map { "WHEN ? THEN ?" }.join(" ")
      sanitized_sql = ActiveRecord::Base.send(
        :sanitize_sql_array,
        [ "position = CASE id #{case_sql} END", *pairs.flatten ]
      )

      SetlistSong.where(id: order, setlist_id: @setlist.id).update_all(sanitized_sql)
    end
end
