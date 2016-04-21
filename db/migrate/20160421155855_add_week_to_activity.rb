class AddWeekToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :week, :integer
  end
end
