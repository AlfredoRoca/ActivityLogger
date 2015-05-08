require 'rails_helper'

RSpec.describe "activities/index", :type => :view do

  it "displays the list of activities" do
    @user =      FactoryGirl.create(:user) 
    @project =   FactoryGirl.create(:project) 
    @task =      FactoryGirl.create(:task) 
    @subtask =   FactoryGirl.create(:subtask, task_id: @task.id) 
    @activity =  FactoryGirl.create(:activity, project_id: @project.id, task_id: @task.id, user_id: @user.id) 
    @activity2 =  FactoryGirl.create(:activity, project_id: @project.id, task_id: @task.id, user_id: @user.id) 
    assign(:activities, Kaminari.paginate_array([@activity, @activity2]).page(1))
    render
    expect(rendered).to include(@project.name, @task.name, @subtask.name, @user.name)
    expect(rendered).to include(localize_date(@activity.start))
    expect(rendered).to include(localize_date(@activity2.start))
  end

end
