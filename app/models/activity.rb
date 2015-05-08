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

class Activity < ActiveRecord::Base
  belongs_to :project
  belongs_to :task
  belongs_to :subtask
  belongs_to :user

  validates :project_id, presence: true
  validates :task_id, presence: true
  validates :user_id, presence: true
  validates :start, presence: true

  scope :with_end, -> { where.not( ended: nil) }
  scope :for_project, -> (id) { where(project_id: id) }
  scope :for_task, -> (id) { where(task_id: id) }
  scope :for_user, -> (id) { where(user_id: id) }

  scope :ordered_last_first, -> { order('start DESC, project_id ASC, task_id ASC, user_id ASC') }

  paginates_per 20

  before_save :calc_duration

  def calc_duration
    # binding.pry
  	if self.ended && self.start
      self.duration = self.ended - self.start
    else
      0
  	end
  end

end
