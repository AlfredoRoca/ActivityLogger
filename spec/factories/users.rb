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
