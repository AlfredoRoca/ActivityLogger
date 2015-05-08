# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  crypted_password :string           not null
#  salt             :string           not null
#  created_at       :datetime
#  updated_at       :datetime
#  name             :string
#  admin            :boolean          default("false")
#

require 'rails_helper'

describe "Integration test", type: :feature do
	
	let!(:admin) { FactoryGirl.create(:user_admin) }

	before(:each) do
		login_user_post(admin.email, "123")
	end

	context "when checking validations" do
		it "rejects without name" do
			user = FactoryGirl.build :user, name: ""
			expect(user.valid?).to be false
			expect(user.errors["name"].present?).to be true
		end
		it "rejects with an existing name" do
			user1 = FactoryGirl.create :user
			user = FactoryGirl.build :user, name: user1.name
			expect(user.valid?).to be false
			expect(user.errors["name"].present?).to be true
		end
		it "rejects without email" do
			user = FactoryGirl.build :user, email: ""
			expect(user.valid?).to be false
			expect(user.errors["email"].present?).to be true
		end
		it "rejects with an existing email" do
			user1 = FactoryGirl.create :user
			user = FactoryGirl.build :user, email: user1.email
			expect(user.valid?).to be false
			expect(user.errors["email"].present?).to be true
		end
		it "rejects with short password" do
			user = FactoryGirl.build :user, password: "1", password_confirmation: "1"
			expect(user.valid?).to be false
			expect(user.errors["password"].present?).to be true
		end
		it "rejects with empty password" do
			user = FactoryGirl.build :user, password: nil, password_confirmation: nil
			expect(user.valid?).to be false
			expect(user.errors["password"].present?).to be true
		end
		it "rejects with password confirmation diferent" do
			user = FactoryGirl.build :user, password: "123", password_confirmation: "1"
			expect(user.valid?).to be false
			expect(user.errors["password_confirmation"].present?).to be true
		end
	end
end
