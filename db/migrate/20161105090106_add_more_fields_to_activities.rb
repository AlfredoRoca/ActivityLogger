class AddMoreFieldsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :chargeable, :boolean, default: true, index: true
    add_column :activities, :charged, :boolean, default: false, index: true
    add_column :activities, :charged_date, :datetime
  end
end
