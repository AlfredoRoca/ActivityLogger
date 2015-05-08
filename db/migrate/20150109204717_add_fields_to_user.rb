class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_reference :users, :role, index: true
  end
end
