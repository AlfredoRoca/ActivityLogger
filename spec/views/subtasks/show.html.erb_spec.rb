require 'rails_helper'

RSpec.describe "subtasks/show", :type => :view do
  before(:each) do
    @subtask = assign(:subtask, Subtask.create!(
      :name => "Name",
      :code => "Code",
      :task => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(//)
  end
end
