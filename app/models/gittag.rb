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

class Gittag < ActiveRecord::Base
  belongs_to :project
end
