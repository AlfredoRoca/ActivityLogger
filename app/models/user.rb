class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  validates :email, presence: true, uniqueness: true

  has_many :activities
  has_many :tasks, -> { uniq }, through: :activities
  has_many :projects, -> { uniq }, through: :activities


  private

  def not_changing_password?
    !changed.include?("encrypted_password")
  end

end
