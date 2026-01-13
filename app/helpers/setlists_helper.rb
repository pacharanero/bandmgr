module SetlistsHelper
  def format_duration(seconds)
    return nil if seconds.blank?

    total = seconds.to_i
    minutes = total / 60
    remaining = total % 60
    format("%d:%02d", minutes, remaining)
  end
end
