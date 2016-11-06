# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           not null
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string
#  admin                  :boolean          default(FALSE)
#  leader                 :boolean          default(FALSE)
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#

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
