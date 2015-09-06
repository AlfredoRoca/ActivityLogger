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

class Task < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :activities
  has_many :subtasks
  has_many :users, -> { uniq }, through: :activities
  default_scope -> { order(:name) }
  scope :how_many_new_activity, -> { limit(5) }
end
