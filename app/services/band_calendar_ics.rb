class BandCalendarIcs
  def initialize(band:, events:, public_feed:)
    @band = band
    @events = events
    @public_feed = public_feed
  end

  def render
    lines = []
    lines << "BEGIN:VCALENDAR"
    lines << "VERSION:2.0"
    lines << "PRODID:-//Bandmgr//Band Calendar//EN"
    lines << "CALSCALE:GREGORIAN"
    lines << "X-WR-CALNAME:#{escape_text(@band.name)}"
    lines << "X-WR-TIMEZONE:UTC"

    @events.each do |event|
      next unless event.starts_at

      lines << "BEGIN:VEVENT"
      lines << "UID:bandmgr-event-#{event.id}@bandmgr"
      lines << "DTSTAMP:#{format_time(Time.current)}"
      lines << "DTSTART:#{format_time(event.starts_at)}"
      lines << "SUMMARY:#{escape_text(summary_for(event))}"
      lines << "LOCATION:#{escape_text(event.venue.to_s)}" if event.venue.present?
      description = description_for(event)
      lines << "DESCRIPTION:#{escape_text(description)}" if description.present?
      lines << "END:VEVENT"
    end

    lines << "END:VCALENDAR"
    lines.join("\r\n")
  end

  private
    def format_time(time)
      time.utc.strftime("%Y%m%dT%H%M%SZ")
    end

    def summary_for(event)
      if @public_feed
        label = event.kind.titleize
        venue = event.venue.presence
        venue ? "#{label} @ #{venue}" : label
      else
        "#{event.kind.titleize} — #{@band.name}"
      end
    end

    def description_for(event)
      return nil if @public_feed

      pieces = []
      pieces << "Venue: #{event.venue}" if event.venue.present?
      pieces << event.notes.to_s.strip if event.notes.present?
      pieces.compact.join("\n")
    end

    def escape_text(text)
      text.to_s.gsub("\\", "\\\\").gsub("\n", "\\n").gsub(",", "\\,").gsub(";", "\\;")
    end
end
