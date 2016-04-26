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

require 'rails_helper'

RSpec.describe Task, type: :model do
  
  context "when checking validations" do
    it "rejects without name" do
      task = FactoryGirl.build :task, name: ""
      expect(task.valid?).to be false
      expect(task.errors["name"].present?).to be true
    end
    it "rejects with an existing name" do
      task1 = FactoryGirl.create :task
      task = FactoryGirl.build :task, name: task1.name.upcase
      expect(task.valid?).to be false
      expect(task.errors["name"].present?).to be true
    end
  end

end
