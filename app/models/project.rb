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
	validates :name, presence: true, uniqueness: { case_sensitive: false }

	has_many :activities, -> { with_end }
  has_many :tasks, -> { uniq }, through: :activities
  has_many :users, -> { uniq }, through: :activities

  scope :activity_ordered, -> { order(id: :desc) }
  scope :alfa_order, -> { order(:name) }
  scope :open, -> { where(closed: false) }
  scope :first_open, -> { order(:closed) }

  audited

  paginates_per 15
end
