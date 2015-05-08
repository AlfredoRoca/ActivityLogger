class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :project, index: true
      t.references :task, index: true
      t.references :subtask, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
