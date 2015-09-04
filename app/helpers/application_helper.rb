module ApplicationHelper
  
  def localize_date_with_weekday(date)
    I18n.l date, format: "%a %d/%m/%Y %H:%M" if date
  end

  def localize_date(date)
    I18n.l date, format: "%d/%m/%Y %H:%M" if date
  end

  def localize_date_only_date(date)
    I18n.l date, format: "%d/%m/%Y" if date
  end

  def duration_to_s(total_seconds)
  	total_seconds ||= 0
  	seconds = total_seconds % 60
  	minutes = (total_seconds / 60) % 60
  	hours = total_seconds / (60 * 60)

  	format("%02d:%02d:%02d", hours, minutes, seconds)
  end

end
