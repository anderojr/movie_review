module MoviesHelper
  def format_duration(minutes)
    return '' if minutes.blank?
    hours = minutes / 60
    mins = minutes % 60
    [("#{hours}h" if hours > 0), ("#{mins}m" if mins > 0)].compact.join(' ')
  end
end
