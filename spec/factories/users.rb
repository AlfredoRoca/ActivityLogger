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

FactoryGirl.define do
  factory :user do
      name                  { Faker::Name.name }
      email                 { Faker::Internet.email }
      admin                 { false }
      password              { "123123123" }
      password_confirmation { "123123123" }
      confirmed_at          DateTime.now

    factory :user_admin do
      name                  { Faker::Name.name }
      email                 { Faker::Internet.email }
      admin                 { true }
      password              { "123123123" }
      password_confirmation { "123123123" }
      confirmed_at          DateTime.now
  	end

    factory :user_invalid do
      email                 nil
    end

  end

end
