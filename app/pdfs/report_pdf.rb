class ReportPdf < Prawn::Document
  include ApplicationHelper
  def initialize(project)
    super()
    @project = project
    @project_start = localize_date @project.activities.first.start
    @project_last_activity = localize_date @project.activities.with_end.last.ended
    settings
    header
    text_content
    move_down 20
    project_tasks_table_content
  end

  def settings
    @font_title = 40
    @font_subtitle = 30
    @font_big = 20
    @font_normal = 14
    @font_little = 10
  end
 
  def header
    #This inserts an image in the pdf file and sets the size of the image
    # image "#{Rails.root}/app/assets/images/header.jpg", width: 530, height: 150
    text "Project #{@project.id} report", size: @font_title, style: :bold
    text @project.name, size: @font_subtitle, style: :bold
  end
 
  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50

    font_size @font_normal
    text "Start: " + @project_start
    text "Last activity: " + @project_last_activity
  end



  def project_tasks_table_content
    text "Tasks", size: @font_big
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
    # table(project_tasks_rows) do
    #   row(0).font_style = :bold
    #   self.header = true
    #   self.row_colors = ['DDDDDD', 'FFFFFF']
    #   self.column_widths = [40, 300, 200]
    # end
    # table(["qwe", "asd", "zxc"])
  end

  def project_tasks_rows
    [['Name', 'Time']] 
    # +
    #   @project.tasks.map do |task|
    #     [task.name, duration_to_s(task.activities.for_project(@project.id).with_end.sum(:duration))]
    #   end
  end

end