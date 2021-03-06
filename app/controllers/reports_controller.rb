class ReportsController < ApplicationController
  before_action :authenticate_user! 

  include ApplicationHelper

  respond_to :html, :json, :pdf

  def activity_report
    starting = format_date(params['starting_date'.to_sym])
    ending = format_date(params['ending_date'.to_sym])
    chargeable = params[:chargeable].upcase unless params[:chargeable].nil?
    charged = params[:charged].upcase unless params[:charged].nil?
    charged_code = params[:charged_code]
    project_id = params[:project]
    task_id = params[:task]
    detailed = params[:detailed] == "1"
    @activities = Activity.filter(starting, ending, chargeable, charged, project_id, task_id, charged_code)
    # unless params[:filter].blank?
    #   project_ids = Project.where("name ILIKE ?", "%#{params[:filter]}%").ids
    #   @activities = @activities.where(project_id: project_ids)
    # end
    @filter_condition = {starting: starting, ending: ending, chargeable: chargeable, charged: charged, charged_code: charged_code, project_id: project_id, task_id: task_id}
    @activities = @activities.order(:project_id, :task_id)

    respond_to do |format|
      format.html { render json: @activities }
      format.json
      format.pdf do
        pdf = ActivityReportPdf.new(@activities, @filter_condition, detailed)
        send_data pdf.render, file_name: 'activity_report.pdf', type: 'application/pdf'
      end
    end
  end

  def project_report
    @project = Project.find(params[:project_id])
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        pdf = ReportPdf.new(@project)
        send_data pdf.render, file_name: 'report.pdf', type: 'application/pdf'
      end
    end
  end

  def user_report
    @user = User.find(params[:user_id])
    respond_with(@user)
  end

  def week_report
  end

  def month_report
    @start = []
    @ended = []
    @month_year = []
    @activities = []
    @number_of_entries = []
    @total_duration = []

    first_activity = Activity.first.start
    absolute_starting_date = first_activity - (first_activity.day - 1).days
    absolute_ending_date = DateTime.now

    while absolute_starting_date <= absolute_ending_date
      month = absolute_starting_date.month
      year = absolute_starting_date.year

      start = DateTime.new(year, month, 1)
      ended = start + 1.month - 1.day
      @start << start
      @ended << ended
      @month_year << {month: month, year: year}

      starting_date = start
      ending_date = ended + 1.day
      
      @activities << Activity.includes(:project).where(start: starting_date .. ending_date).group(:name).sum(:duration)
      @number_of_entries << Activity.where(start: starting_date .. ending_date).count
      @total_duration << Activity.where(start: starting_date .. ending_date).sum(:duration)

      absolute_starting_date += 1.month

    end 
  end

  def new_week_report
    @start = params[:start]
    @ended = params[:ended]
    starting_date = DateTime.parse(@start)
    ending_date = DateTime.parse(@ended) + 1.day

    @activities = Activity.includes(:project).where(start: starting_date .. ending_date).group(:name).sum(:duration)
    @number_of_entries = Activity.where(start: starting_date .. ending_date).count
    @total_duration = Activity.where(start: starting_date .. ending_date).sum(:duration)

    @week = params[:week]
    # respond_to do |format|
    #   format.html { }
    #   format.js {}
    # end

  end

  def year_report
    @start = []
    @ended = []
    @year = []
    @activities = []
    @number_of_entries = []
    @total_duration = []

    first_activity = Activity.first.start
    absolute_starting_date = first_activity - (first_activity.day - 1).days
    absolute_ending_date = DateTime.now

    begin
      year = absolute_starting_date.year

      start = DateTime.new(year, 1, 1)
      ended = start + 1.year - 1.day
      @start << start
      @ended << ended
      @year << year

      starting_date = start
      ending_date = ended + 1.day
      
      @activities << Activity.includes(:project).where(start: starting_date .. ending_date).group(:name).sum(:duration)
      @number_of_entries << Activity.where(start: starting_date .. ending_date).count
      @total_duration << Activity.where(start: starting_date .. ending_date).sum(:duration)
      absolute_starting_date += 1.year

    end until absolute_starting_date > absolute_ending_date
  end

  def weekly_for_project_report
    @project = Project.includes(:activities, :tasks).find_by(id: params[:project_id])

    @activities = @project.activities
    unless @activities.blank?
      @tasks = @project.tasks

      @project_starting_date = @activities.first.start
      @project_ending_date = (@activities.last.try(:ended) || @activities.last.start) + 1.day
      @project_age = distance_of_time_in_words(@project_starting_date, @project_ending_date)
      @project_age_until_now = distance_of_time_in_words_to_now(@project_starting_date)
      
      @weekly_duration = @activities.order(:year, :week).group(:year, :week).sum(:duration)
      @weekly_entries = @activities.order(:year, :week).group(:year, :week).count

      # weekly_activity is a hash resulting the combination of _duration and _entries
      # => [yyyy, week]=>[entries, duration]
      # {[2015, 1]=>[9, 58500], [2015, 6]=>[1, 11400], [2015, 9]=>[1, 12300], [2015, 10]=>[3, 33600], [2016, 1]=>[1, 64800]}
      @weekly_activity = @weekly_entries.merge(@weekly_duration){|key,oldval,newval| [*oldval].to_a + [*newval.to_i].to_a }

      @total_duration = @activities.sum(:duration)

      respond_to do |format|
        format.html
        format.json
      end
    else
      respond_to do |format|
        format.html { render 'project_without_activity_report' }
        format.json { render json: "No activity" }
      end
    end
  end


end
