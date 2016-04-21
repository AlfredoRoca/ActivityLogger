class AddYearToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :year, :integer
  end
end
