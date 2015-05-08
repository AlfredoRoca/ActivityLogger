# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  project_id :integer
#  task_id    :integer
#  subtask_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  start      :datetime
#  ended      :datetime
#  duration   :decimal(, )
#

require 'rails_helper'

describe "Integration test", type: :feature do
	
	let!(:admin) { FactoryGirl.create(:user_admin) }
	let!(:project) { FactoryGirl.create(:project) }
	let!(:task) { FactoryGirl.create(:task) }

	before(:each) do
		login_user_post(admin.email, "123")
	end
	
	it "signs me in" do
    expect(page).to have_content 'You are being redirected'
  end

	context "when checking validations" do
		it "rejects without project" do
			activity = FactoryGirl.build :activity, project_id: nil, task_id: task.id
			expect(activity.valid?).to be false
			expect(activity.errors["project_id"].present?).to be true
		end
		it "rejects without task" do
			activity = FactoryGirl.build :activity, project_id: project.id, task_id: nil
			expect(activity.valid?).to be false
			expect(activity.errors["task_id"].present?).to be true
		end
		it "rejects without start date" do
			activity = FactoryGirl.build :activity, project_id: project.id, task_id: task.id, start: nil
			expect(activity.valid?).to be false
			expect(activity.errors["start"].present?).to be true
		end


	end

end

