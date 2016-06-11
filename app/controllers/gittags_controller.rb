class GittagsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_project
  before_action :set_gittag, only: [:show, :edit, :update, :destroy]

  def index
    @gittags = @project.gittags
  end

  def edit
  end

  def update
    respond_to do |format|
      if @gittag.update(gittag_params)
        format.html { redirect_to @gittag, notice: 'gittag was successfully updated.' }
        format.json { render :show, status: :ok, location: @gittag }
      else
        format.html { render :edit }
        format.json { render json: @gittag.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def new
    @gittag = @project.gittags.new
  end

  def create
    # "* 66ab102 2016-03-25 19:01:53 +0100  (HEAD, tag: v0.3, origin/master, master) shows again prices plans\r\n* 48c8c4a 2016-03-10 14:24:17 +0100  (tag: v0.2) notifies manager about new documents uploaded\r\n* ce15b5a 2016-03-09 11:49:33 +0100  (tag: v0.1) more on user tests\r\n"
    @project.gittags.clear
    params[:gittags_text].each_line do |line| 
      gitline = line.split(" ", 6)
      @gittag = @project.gittags.create(commit: gitline.slice(1,1).first, date: DateTime.parse(gitline.slice(2,3).join(" ")).iso8601, description: gitline.slice(5, gitline.size).first )

    end

      # [["*", "66ab102", "2016-03-25", "19:01:53", "+0100", "(HEAD, tag: v0.3, origin/master, master) shows again prices plans\r\n"],
      #  ["*", "48c8c4a", "2016-03-10", "14:24:17", "+0100", "(tag: v0.2) notifies manager about new documents uploaded\r\n"],
      #  ["*", "ce15b5a", "2016-03-09", "11:49:33", "+0100", "(tag: v0.1) more on user tests\r\n"]]

    @project.calculate_activity_duration_per_gittag

    redirect_to request.referer, notice: 'Gittag was successfully created.'
  end

  def destroy
    @gittag.destroy
    redirect_to request.referer
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def set_gittag
    @gittag = Gittag.find_by(id: params[:id])
  end

    def gittag_params
      params.require(:gittag).permit(:project_id, :commit, :date, :description)
    end
end
