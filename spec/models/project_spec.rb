# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe "Integration test", type: :feature do
	
	let!(:admin) { FactoryGirl.create(:user_admin) }

	before(:each) do
		login_user_post(admin.email, "123")
	end

	context "when checking validations" do
		it "rejects without name" do
			project = FactoryGirl.build :project, name: ""
			expect(project.valid?).to be false
			expect(project.errors["name"].present?).to be true
		end
		it "rejects with an existing name" do
			project1 = FactoryGirl.create :project
			project = FactoryGirl.build :project, name: project1.name
			expect(project.valid?).to be false
			expect(project.errors["name"].present?).to be true
		end
	end

end

