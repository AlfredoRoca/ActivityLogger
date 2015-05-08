require 'rails_helper'

RSpec.describe "activities/new", :type => :view do
  before(:each) do
    @user = FactoryGirl.create :user
    @project = FactoryGirl.create :project
    @task = FactoryGirl.create :task
    @activity = assign(:activity, Activity.create!(
      :project_id => @project.id,
      :task_id => @task.id,
      :user_id => @user.id,
      start: DateTime.now
    ))
  end

  it "renders new activity form" do
    render

    assert_select "form[action=?][method=?]", activity_path(@activity), "post" do

      assert_select "input#activity_project_id_" + @project.id.to_s + "[name=?]", "activity[project_id]"

      assert_select "input#activity_task_id_" + @task.id.to_s + "[name=?]", "activity[task_id]"

      assert_select "input#activity_subtask_id[name=?]", "activity[subtask_id]"
    end
  end
end
