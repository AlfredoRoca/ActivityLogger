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

class Subtask < ActiveRecord::Base
  belongs_to :task, dependent: :destroy
  has_many :activities
  default_scope -> { order(:name) }
  scope :how_many_new_activity, -> { limit(2) }
end
