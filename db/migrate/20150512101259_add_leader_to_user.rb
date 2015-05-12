class AddLeaderToUser < ActiveRecord::Migration
  def change
    add_column :users, :leader, :boolean, default: false
  end
end
