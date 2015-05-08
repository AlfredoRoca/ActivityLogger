class AddClosedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :closed, :boolean
  end
end
