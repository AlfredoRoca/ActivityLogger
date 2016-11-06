require 'prawn/table'
class ActivityReportPdf < Prawn::Document
  include ApplicationHelper
  def initialize(activities, filter)
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
      # page_layout: :portrait,
      page_layout: :landscape,
      left_margin: 50,
    )

    @activities = activities
    @starting = filter[:starting]
    @ending = filter[:ending]
    @chargeable = filter[:chargeable]
    @charged = filter[:charged]
    settings
    header
    move_down 20
    font_size @font_little
    print_list
    move_down 20
    print_summary_per_project
    move_down 20
    print_activity_summary

    page_numbering
  end

  def settings
    @font_title = 30
    @font_subtitle = 26
    @font_big = 20
    @font_normal = 12
    @font_little = 10
    @font_tiny = 8
    @tables_width_wide = 775
    @tables_width_narrow = 500
  end
 
  def header
    text "Activities started between #{localize_date(DateTime.parse(@starting))} and #{localize_date(DateTime.parse(@ending))}", size: @font_big, style: :bold
    text "Other conditions: chargeable: #{@chargeable}, charged: #{@charged}", size: @font_normal
  end
 
  def table_header_for_activities_list
    [
      "Project",
      "Task",
      "Subtask",
      "Start",
      "Finish",
      "Duration",
      "Description"
    ]      
  end

  def print_list
    text "Activities", size: @font_normal, style: :bold
    data = []
    data[0] = table_header_for_activities_list
    data = populate_table_for_activities_list(data, @activities)
    table(data) do
      header = true
      width = @tables_width_wide
      cells.borders = [:bottom]
      cells.style = {overflow: :shrink_to_fit, min_font_size: @font_tiny,}
      row(0).font_style = :bold
    end
  end

  def populate_table_for_activities_list(data, activities)
    activities.each do |activity|
      data << [
        activity.project.try(:name),
        activity.task.try(:name),
        activity.subtask.try(:name),
        localize_date(activity.start),
        localize_date(activity.ended),
        duration_to_s(activity.duration),
        activity.description
      ]
    end
    data
  end

  def print_activity_summary
    total_duration = duration_to_s(@activities.sum(:duration))
    total_lines = @activities.size
    summary_line = "Total duration: #{total_duration} in #{total_lines} lines"
    text summary_line, size: @font_normal, style: :bold
    daily_hours = 8
    working_days = total_duration.split(':').first.to_f / daily_hours
    h,m,s = total_duration.split(':').map(&:to_i)
    text "#{working_days} working days of #{daily_hours} hours (#{h/daily_hours} w.d. + #{h%daily_hours} h)"
  end

  def print_summary_per_project
    text "Summary per project", size: @font_normal, style: :bold
    activities_summary = @activities.order(:project_id, "activities.task_id").group(:project_id, "activities.task_id").sum(:duration)
    per_project_and_task_summary = activities_summary.map{|activity| {project: Project.find(activity[0][0]), task: Task.find(activity[0][1]), duration: activity[1].to_i}}

    draw_horizontal_line
    data = []
    data[0] = table_header_for_summary_per_project
    data = populate_table_for_summary_per_project(data, per_project_and_task_summary)
    table(data) do
      header = true
      width = @tables_width_narrow
      cells.borders = [:bottom]
      cells.style = {overflow: :shrink_to_fit, min_font_size: @font_tiny}
      row(0).font_style = :bold
    end

  end

  def table_header_for_summary_per_project
    [
      "Project",
      "Task",
      "Duration"
    ]      
  end

  def populate_table_for_summary_per_project(data, activities_summary)
    activities_summary.each do |summary|
      data << [
        summary[:project].name,
        summary[:task].name,
        duration_to_s(summary[:duration])
      ]
    end
    data
  end

def page_numbering
    string = "Página <page> de <total>"
    options = { :at => [bounds.right - 150, 0],
    :width => 150,
    :align => :right }
    number_pages string, options
  end
  
  def draw_horizontal_line
    # text "\n"
    stroke do
      line_width = 1
      horizontal_rule
    end
    text "\n"
  end


end