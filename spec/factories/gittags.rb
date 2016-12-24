# == Schema Information
#
# Table name: gittags
#
#  id                :integer          not null, primary key
#  commit            :string
#  date              :datetime
#  description       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  project_id        :integer
#  activity_duration :string
#

FactoryGirl.define do
  factory :gittag do
    commit "MyString"
    date "2016-06-11 14:32:05"
    description "MyString"
  end
end
