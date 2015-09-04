class AddAliasToProject < ActiveRecord::Migration
  def change
    add_column :projects, :alias, :string
  end
end
