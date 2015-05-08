# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string
#  code       :string
#  created_at :datetime
#  updated_at :datetime
#

require 'faker'

FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.word }
		code "CO"
		
	  factory :task_invalid do
	  	name { nil }
	  end
  end

end
