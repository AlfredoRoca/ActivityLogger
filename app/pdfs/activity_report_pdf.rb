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
    print_activity_summary
    print_summary_per_project

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
      line_text += "#{localize_date(activity.start)} - #{localize_date(activity.ended)} = #{duration_to_s(activity.duration)} #{activity.description}"
      text line_text
    end
  end

  def print_activity_summary
    total_duration = duration_to_s(@activities.sum(:duration))
    total_lines = @activities.size
    summary_line = "Total duration: #{total_duration} in #{total_lines} lines"
    text summary_line, size: @font_big, style: :bold
    daily_hours = 8
    working_days = total_duration.split(':').first.to_f / daily_hours
    h,m,s = total_duration.split(':').map(&:to_i)
    text "#{working_days} working days of #{daily_hours} hours (#{h/daily_hours} w.d. + #{h%daily_hours} h)"
  end

  def print_summary_per_project
    per_project_and_task_summary = @activities.order(:project_id, :task_id).group(:project_id, :task_id).sum(:duration).map{|activity| {project: Project.find(activity[0][0]), task: Task.find(activity[0][1]), duration: activity[1].to_i}}

    per_project_and_task_summary.each do |summary|
      text "#{summary[:project].name} #{summary[:task].name} #{duration_to_s(summary[:duration])}"
    end
    move_down 20
  end

  def page_numbering
    string = "Página <page> de <total>"
    options = { :at => [bounds.right - 150, 0],
    :width => 150,
    :align => :right }
    number_pages string, options
  end
  


end