require 'rails_helper'

RSpec.describe "subtasks/index", :type => :view do
  it "displays the list of subtasks" do
    @subtask =   FactoryGirl.create(:subtask) 
    @subtask1 =   FactoryGirl.create(:subtask) 
    @subtask2 =   FactoryGirl.create(:subtask) 
    assign(:subtasks, [@subtask, @subtask1, @subtask2])
    render
    expect(rendered).to include(@subtask.name, @subtask1.name, @subtask2.name)
  end
end
