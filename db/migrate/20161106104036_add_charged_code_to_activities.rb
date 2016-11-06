class AddChargedCodeToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :charged_code, :string, default: ""
  end
end
