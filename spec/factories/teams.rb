require 'faker'

FactoryGirl.define do
  factory :team do
    name {Faker::Lorem.word}

    factory :invalid_team do
      name nil
    end
  end

end
