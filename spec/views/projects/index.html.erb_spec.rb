require 'rails_helper'

RSpec.describe "projects/index", :type => :view do
  it "displays the list of projects" do
    @project =   FactoryGirl.create(:project) 
    @project1 =   FactoryGirl.create(:project) 
    @project2 =   FactoryGirl.create(:project) 
    assign(:projects, [@project, @project1, @project2])
    render
    expect(rendered).to include(@project.name, @project1.name, @project2.name)
  end
end
