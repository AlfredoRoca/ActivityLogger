class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  def upload_activities_file
    @filename = params[:import_file_name]
    @parsed_lines = Activity.read_activity_file(@filename)
    render 'check_import_file'
  end

  def execute_import
    filename = params[:import_file_name]
    @parsed_lines = Activity.read_activity_file(filename)
    result = Activity.execute_import(current_user.id, @parsed_lines)
    # render text: result
    redirect_to activities_url, notice: "#{result} activities were created."
  end

  # GET /activities
  # GET /activities.json
  def index
    if current_user.admin
      @activities = Activity.all.ordered_last_first.page params[:page]
    else
      @activities = Activity.for_user(current_user.id).ordered_last_first.page params[:page]
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:project_id, :task_id, :subtask_id, :user_id, :start, :ended, :duration)
    end
end
