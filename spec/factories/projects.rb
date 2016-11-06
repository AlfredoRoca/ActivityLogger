# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#  closed     :boolean
#  alias      :string
#

require 'faker'

FactoryGirl.define do
  factory :project do
    name {Faker::Lorem.word}

    factory :project_invalid do
    	name nil
    end
  end

end
