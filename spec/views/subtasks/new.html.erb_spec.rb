require 'rails_helper'

RSpec.describe "subtasks/new", :type => :view do
  before(:each) do
    assign(:subtask, Subtask.new(
      :name => "MyString",
      :code => "MyString",
      :task => nil
    ))
  end

  it "renders new subtask form" do
    render

    assert_select "form[action=?][method=?]", subtasks_path, "post" do

      assert_select "input#subtask_name[name=?]", "subtask[name]"

      assert_select "input#subtask_code[name=?]", "subtask[code]"

      assert_select "input#subtask_task_id[name=?]", "subtask[task_id]"
    end
  end
end
