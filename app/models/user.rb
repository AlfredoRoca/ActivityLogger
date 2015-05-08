# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  crypted_password :string           not null
#  salt             :string           not null
#  created_at       :datetime
#  updated_at       :datetime
#  name             :string
#  admin            :boolean          default("false")
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  has_many :activities
  has_many :tasks, -> { uniq }, through: :activities
  has_many :projects, -> { uniq }, through: :activities

end
