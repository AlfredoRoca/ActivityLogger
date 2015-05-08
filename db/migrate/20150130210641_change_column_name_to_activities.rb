class ChangeColumnNameToActivities < ActiveRecord::Migration
  def change
    rename_column :activities, :end, :ended
  end
end
