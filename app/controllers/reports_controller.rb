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

    begin
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

    end until absolute_starting_date > absolute_ending_date
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


end
