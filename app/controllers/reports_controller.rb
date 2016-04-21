class ReportsController < ApplicationController
  
  before_filter :require_admin

  respond_to :html, :json, :pdf

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
    @project = Project.includes(:activities, :tasks).find(params[:project_id])

    @activities = @project.activities
    @tasks = @project.tasks

    @project_starting_date = @activities.first.start
    @project_ending_date = (@activities.last.try(:ended) || @activities.last.start) + 1.day
    
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
      format.pdf do
        pdf = ReportPdf.new(@project)
        send_data pdf.render, file_name: 'report.pdf', type: 'application/pdf'
      end
    end
  end


end
