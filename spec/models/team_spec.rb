require 'rails_helper'

describe "Integration test", type: :feature do
  
  let!(:admin) { FactoryGirl.create(:user_admin) }

  before(:each) do
    login_user_post(admin.email, "123")
  end

  context "when checking validations" do
    it "rejects without name" do
      team = FactoryGirl.build :team, name: ""
      expect(team.valid?).to be false
      expect(team.errors["name"].present?).to be true
    end
    it "rejects with an existing name" do
      project1 = FactoryGirl.create :team
      team = FactoryGirl.build :team, name: project1.name
      expect(team.valid?).to be false
      expect(team.errors["name"].present?).to be true
    end
  end

end
