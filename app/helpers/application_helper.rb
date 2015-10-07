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

end
