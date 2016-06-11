# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Project < ActiveRecord::Base

  include ApplicationHelper

	validates :name, presence: true, uniqueness: { case_sensitive: false }

	has_many :activities, -> { with_end }
  has_many :tasks, -> { uniq }, through: :activities
  has_many :users, -> { uniq }, through: :activities
  has_many :gittags

  scope :activity_ordered, -> { order(id: :desc) }
  scope :alfa_order, -> { order(:name) }
  scope :open, -> { where(closed: false) }
  scope :first_open, -> { order(:closed) }

  audited

  paginates_per 15

  def calculate_activity_duration_per_gittag
    all_gittags = gittags.order(date: :asc)
    previous_date = DateTime.parse("1/1/1970").iso8601 # initial date
    all_gittags.map do |gt|
      gt.update_column(:activity_duration, long_duration_to_s(activities.where("start >= ? and start <= ?", previous_date, gt.date).sum(:duration)))
      previous_date = gt.date
    end
  end
end
