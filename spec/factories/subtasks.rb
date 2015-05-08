# == Schema Information
#
# Table name: subtasks
#
#  id         :integer          not null, primary key
#  name       :string
#  code       :string
#  task_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'faker'

FactoryGirl.define do
  factory :subtask do
    name Faker::Lorem.word
		code "CO"
		task_id 1
  end

end
