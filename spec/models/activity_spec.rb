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

require 'rails_helper'

RSpec.describe Activity, type: :model do
  
  let(:admin)   { FactoryGirl.create(:user_admin) }
  let(:user)    { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:task)    { FactoryGirl.create(:task) }
  
  context "when checking validations" do
    it "rejects without project" do
      activity = FactoryGirl.build :activity, project_id: nil, task_id: task.id, user_id: user.id
      expect(activity.valid?).to be false
      expect(activity.errors["project_id"].present?).to be true
    end
    it "rejects without task" do
      activity = FactoryGirl.build :activity, project_id: project.id, task_id: nil, user_id: user.id
      expect(activity.valid?).to be false
      expect(activity.errors["task_id"].present?).to be true
    end
    it "rejects without user" do
      activity = FactoryGirl.build :activity, project_id: project.id, task_id: task.id, user_id: nil
      expect(activity.valid?).to be false
      expect(activity.errors["user_id"].present?).to be true
    end
    it "rejects without start date" do
      activity = FactoryGirl.build :activity, project_id: project.id, task_id: task.id, user_id: user.id, start: nil
      expect(activity.valid?).to be false
      expect(activity.errors["start"].present?).to be true
    end


  end

end

