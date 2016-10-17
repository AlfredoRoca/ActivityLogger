class ActivityReportPdf < Prawn::Document
  include ApplicationHelper
  def initialize(activities, starting, ending)
    super(
      info: {
        Title: "Activity report",
        Subject: "Activity list report",
        Author: "Alfredo Roca",
        Creator: "ARM",
        ModificationDate: Time.zone.now,
        CreationDate: Time.zone.now
        },
      page_size: "A4",
      page_layout: :portrait,
      left_margin: 50,
    )

    @activities = activities
    @starting = starting
    @ending = ending
    settings
    header
    move_down 20
    print_list
    move_down 20
    print_summary

    page_numbering
  end

  def settings
    @font_title = 40
    @font_subtitle = 30
    @font_big = 20
    @font_normal = 14
    @font_little = 10
  end
 
  def header
    text "Activities started between #{localize_date(DateTime.parse(@starting))} and #{localize_date(DateTime.parse(@ending))}", size: @font_subtitle, style: :bold
  end
 

  def print_list
    text "Activities", size: @font_big
    @activities.each do |activity|
      line_text = ""
      line_text += "#{activity.project.try(:name)} "
      line_text += "#{activity.task.try(:name)} "
      line_text += "#{activity.subtask.try(:name)} "
      line_text += "#{activity.start} - #{activity.ended} = #{duration_to_s(activity.duration)} #{activity.description}"
      text line_text
    end
  end

  def print_summary
    total_duration = duration_to_s(@activities.sum(:duration))
    summary_line = "Total duration: #{total_duration}"
    text summary_line, size: @font_subtitle, style: :bold
    text "#{total_duration.split(':').first.to_i / 8} working days"
  end

  def page_numbering
    string = "Página <page> de <total>"
    options = { :at => [bounds.right - 150, 0],
    :width => 150,
    :align => :right }
    number_pages string, options
  end
  


end