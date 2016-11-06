# == Schema Information
#
# Table name: activities
#
#  id           :integer          not null, primary key
#  project_id   :integer
#  task_id      :integer
#  subtask_id   :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  start        :datetime
#  ended        :datetime
#  duration     :decimal(, )
#  description  :string
#  week         :integer
#  year         :integer
#  chargeable   :boolean          default(TRUE)
#  charged      :boolean          default(FALSE)
#  charged_date :datetime
#  charged_code :string           default("")
#

FactoryGirl.define do
  factory :activity do
    project_id 	1
		task_id 		1
		user_id 		1
		start				{ I18n.l DateTime.now, format: "%d/%m/%Y %H:%M" }
    description { Faker::Lorem.sentence }
  end

end
