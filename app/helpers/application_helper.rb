module ApplicationHelper
  
  def localize_date_with_weekday(date)
    I18n.l date, format: "%a %d/%m/%Y %H:%M" if date.is_a?(Date) || date.is_a?(Time) || date.is_a?(DateTime)
  end

  def localize_date(date)
    I18n.l date, format: "%d/%m/%Y %H:%M" if date.is_a?(Date) || date.is_a?(Time) || date.is_a?(DateTime)
  end

  def localize_date_only_date(date)
    I18n.l date, format: "%d/%m/%Y" if date.is_a?(Date) || date.is_a?(Time) || date.is_a?(DateTime)
  end

  def duration_to_s(total_seconds)
    total_seconds ||= 0
    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / (60 * 60)

    # format("%02d:%02d:%02d", hours, minutes, seconds)
    format("%02d:%02d", hours, minutes)
  end

  def long_duration_to_s(total_seconds)
    (total_seconds/3600).ceil.to_s + "h"
  end

  def format_date(date)
    # Convert "DD/MM/YYYY HH:MM" (picker format) to "YYYYMMDD HHMMSS" (DB format)
    date.slice(6,4) + date.slice(3,2) + date.slice(0,2) + " " + date.slice(11,2) + date.slice(14,2) + "00" unless date.nil? || date.length != 16
  end

end
