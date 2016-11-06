# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'faker'

FactoryGirl.define do
  factory :team do
    name {Faker::Lorem.word}

    factory :invalid_team do
      name nil
    end
  end

end
