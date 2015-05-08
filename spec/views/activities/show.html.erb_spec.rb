require 'rails_helper'

RSpec.describe "activities/show", :type => :view do
  before(:each) do
    @user = FactoryGirl.create :user
    @project = FactoryGirl.create :project
    @task = FactoryGirl.create :task
    @subtask = FactoryGirl.create :subtask, task_id: @task.id
    @activity = assign(:activity, Activity.create!(
      :project_id => @project.id,
      :task_id => @task.id,
      :subtask_id => @subtask.id,
      :user_id => @user.id,
      start: DateTime.now
    ))
  end

  it "renders attributes" do
    render
    expect(rendered).to match(/#{@project.name}/)
    expect(rendered).to match(/#{@task.name}/)
    expect(rendered).to match(/#{@subtask.name}/)
    expect(rendered).to match(/#{@user.name}/)
  end
end
