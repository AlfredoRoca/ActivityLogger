# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  project_id :integer
#  task_id    :integer
#  subtask_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  start      :datetime
#  ended      :datetime
#  duration   :decimal(, )
#

FactoryGirl.define do
  factory :activity do
    project_id 	1
		task_id 		1
		subtask_id 	1
		user_id 		1
		start				DateTime.now

		factory :activity_invalid do
			project_id	nil
			task_id			nil
			subtask_id 	1
			user_id 		1
		end
  end

end
