# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Team, type: :model do
  
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
