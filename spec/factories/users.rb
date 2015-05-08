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

require 'faker'

FactoryGirl.define do
  factory :user do
      name                  {Faker::Name.name}
      email                 {Faker::Internet.email}
      admin                 {false}
      password              {"123"}
      password_confirmation {"123"}

    factory :user_admin do
      name                  {Faker::Name.name}
      email                 {Faker::Internet.email}
      admin                 {true}
      password              {"123"}
      password_confirmation {"123"}
  	end

    factory :user_invalid do
      email                 nil
    end

  end

end
