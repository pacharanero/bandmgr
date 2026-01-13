class SetlistPdf
  def initialize(setlist:, songs:, settings:)
    @setlist = setlist
    @songs = songs
    @settings = settings
  end

  def render
    Prawn::Document.new(page_size: "A4", margin: 48) do |pdf|
      pdf.text @setlist.title, size: 20, style: :bold
      pdf.text @setlist.band.name, size: 12, color: "666666"
      pdf.move_down 12

      pdf.text @setlist.description.to_s, size: 10 if @setlist.description.present?
      pdf.move_down 12 if @setlist.description.present?

      @songs.each_with_index do |setlist_song, index|
        song = setlist_song.song
        line = "#{index + 1}. #{song.title}"
        line += " — #{song.artist}" if include?(:artist) && song.artist.present?
        pdf.text line, size: 12

        details = []
        details << "Key: #{song.key}" if include?(:key) && song.key.present?
        details << "Tempo: #{song.tempo}" if include?(:tempo) && song.tempo.present?
        details << "Duration: #{format_duration(song.duration_seconds)}" if include?(:duration) && song.duration_seconds.present?
        details << "Tags: #{song.tags.order(:name).pluck(:name).join(", ")}" if include?(:tags) && song.tags.any?
        pdf.text details.join(" · "), size: 9, color: "666666" if details.any?
        pdf.text song.notes.to_s, size: 9 if include?(:notes) && song.notes.present?

        pdf.move_down 8
      end
    end.render
  end

  private
    def include?(key)
      @settings.fetch(key, false)
    end

    def format_duration(seconds)
      total = seconds.to_i
      minutes = total / 60
      remaining = total % 60
      format("%d:%02d", minutes, remaining)
    end
end
