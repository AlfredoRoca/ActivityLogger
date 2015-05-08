class AddFieldsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :start, :datetime
    add_column :activities, :end, :datetime
    add_column :activities, :duration, :decimal
  end
end
