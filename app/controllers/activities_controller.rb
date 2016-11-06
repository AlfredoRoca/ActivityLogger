class ActivitiesController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  include ApplicationHelper

  def upload_activities_file
    filename = params[:import_file_name]
    @original_filename = filename.original_filename
    @parsed_lines = Activity.read_activity_file(filename)
    @total_lines = @parsed_lines.count
    @must_check = @parsed_lines.count{|l| l[:must_check] == true}
    @invalid = @parsed_lines.count{|l| l[:invalid] == true}
    render 'check_import_file'
  end

  def execute_import
    original_filename = params[:original_filename]
    result = Activity.execute_import(current_user.id, original_filename)
    redirect_to activities_url, notice: "#{result} activities were created."
  end

  # GET /activities
  # GET /activities.json
  def index
    # The code in the bootstrap-tables makes ajax call
    date_time_picker_format = "%d/%m/%Y %H:%M"
    params['starting_date'.to_sym] = (Time.now - 1.week).strftime(date_time_picker_format) if params['starting_date'.to_sym].blank?
    params['ending_date'.to_sym] = Time.now.strftime(date_time_picker_format) if params['ending_date'.to_sym].blank?
    starting = format_date(params['starting_date'.to_sym])
    ending = format_date(params['ending_date'.to_sym])
    chargeable = params[:chargeable].upcase unless params[:chargeable].nil?
    charged = params[:charged].upcase unless params[:charged].nil?
    charged_code = params[:charged_code]
    project_id = params[:project]
    @starting_date = params[:starting_date]
    @ending_date = params[:ending_date]

    if request.path_parameters[:format] == 'json'
      if current_user.admin
        @activities = Activity.filter(starting, ending, chargeable, charged, project_id, charged_code)
          # @activities = Activity.where('start >= ? and start <= ?', starting, ending).includes(:project, :task, :subtask, :user)
          # @activities = @activities.chargeables if chargeable == "YES"
          # @activities = @activities.not_chargeable if chargeable == "NO"
          # @activities = @activities.chargeds if charged == "YES"
          # @activities = @activities.not_charged if charged == "NO"
      else
        @activities = Activity.for_user(current_user.id).includes(:project, :task, :subtask, :user)
        # @activities = Activity.for_user(current_user.id).ordered_last_first.page params[:page]
      end
    else
      @activities = Activity.none
    end
  end

  # POST '/activities/charge(.:format)' by ajax from index page
  def charge
    starting = format_date(params['starting_date'.to_sym])
    ending = format_date(params['ending_date'.to_sym])
    chargeable = params[:chargeable].upcase unless params[:chargeable].nil?
    charged = params[:charged].upcase unless params[:charged].nil?
    charged_date = params[:charged_date]
    charged_code = params[:charged_code]
    project_id = params[:project]
    activities = Activity.filter(starting, ending, chargeable, charged, project_id, charged_code)
    # unless params[:filter].blank?
    #   project_ids = Project.where("name ILIKE ?", "%#{params[:filter]}%").ids
    #   activities = activities.where(project_id: project_ids)
    # end
    filter_condition = {starting: starting, ending: ending, chargeable: chargeable, charged: charged, project: project_id}
    activities = activities.order(:project_id, :task_id)
    quantity = activities.size
    charged_code = generate_random_string
    activities.update_all(charged: true, charged_code: charged_code, charged_date: charged_date.in_time_zone, updated_at: DateTime.now)
    activities.reload
    response = {result: 'updated', quantity: quantity, charged_code: charged_code, charged_date: charged_date}
    render json: response.to_json
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params.merge(user_id: current_user.id))
    # render text: params

    respond_to do |format|
      if @activity.save
        format.html { redirect_to activities_url, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: activities_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    # render text: params
    respond_to do |format|
      if @activity.update(activity_params.merge(user_id: current_user.id))
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # request with ajax from popup in index
  def toggle_chargeable
    @activity = Activity.find_by(id: params[:activity_id])
    @activity.update(chargeable: !@activity.chargeable)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:project_id, :task_id, :subtask_id, :user_id, :start, :ended, :duration, :description, :week, :year, :chargeable, :charged, :charged_date, :charged_code)
    end
end
