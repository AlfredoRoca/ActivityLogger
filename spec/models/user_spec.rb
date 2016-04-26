require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "when checking validations" do
    it "rejects without email", :aggregate_failures do
      user = FactoryGirl.build :user, email: ""
      expect(user.valid?).to be false
      expect(user.errors["email"].present?).to be true
    end
    it "rejects with an existing email", :aggregate_failures do
      user1 = FactoryGirl.create :user
      user = FactoryGirl.build :user, email: user1.email
      expect(user.valid?).to be false
      expect(user.errors["email"].present?).to be true
    end
  end
end
