require 'rails_helper'

RSpec.describe "tasks/index", :type => :view do
  it "displays the list of tasks" do
    @task =   FactoryGirl.create(:task) 
    @task1 =   FactoryGirl.create(:task) 
    @task2 =   FactoryGirl.create(:task) 
    assign(:tasks, [@task, @task1, @task2])
    render
    expect(rendered).to include(@task.name, @task1.name, @task2.name)
  end
end
