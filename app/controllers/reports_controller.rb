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

  def new_week_report

    @start = params[:start]
    @ended = params[:ended]

    @activities = Activity.joins(:project).select('projects.name').where("start >= to_timestamp('#{params[:start]}', 'DD/MM/YYYY') - interval '#{offset_utc} hours'").where("start <= to_timestamp('#{params[:ended]} 23:59:59', 'DD/MM/YYYY HH24:MI:SS') - interval '#{offset_utc} hours'").group(:name).sum(:duration)

    @number_of_entries = Activity.where("start >= to_timestamp('#{params[:start]}', 'DD/MM/YYYY') - interval '#{offset_utc} hours'").where("start <= to_timestamp('#{params[:ended]} 23:59:59','DD/MM/YYYY HH24:MI:SS') - interval '#{offset_utc} hours'").count

    @total_duration = Activity.where("start >= to_timestamp('#{params[:start]}', 'DD/MM/YYYY') - interval '#{offset_utc} hours'").where("start <= to_timestamp('#{params[:ended]} 23:59:59', 'DD/MM/YYYY HH24:MI:SS') - interval '#{offset_utc} hours'").sum('duration')

    @week = params[:week]
    # respond_to do |format|
    #   format.html { }
    #   format.js {}
    # end

  end


end
