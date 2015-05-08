require 'rails_helper'

RSpec.describe "subtasks/edit", :type => :view do
  before(:each) do
    @subtask = assign(:subtask, Subtask.create!(
      :name => "MyString",
      :code => "MyString",
      :task => nil
    ))
  end

  it "renders the edit subtask form" do
    render

    assert_select "form[action=?][method=?]", subtask_path(@subtask), "post" do

      assert_select "input#subtask_name[name=?]", "subtask[name]"

      assert_select "input#subtask_code[name=?]", "subtask[code]"

      assert_select "input#subtask_task_id[name=?]", "subtask[task_id]"
    end
  end
end
