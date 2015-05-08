class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.string :name
      t.string :code
      t.references :task, index: true

      t.timestamps
    end
  end
end
