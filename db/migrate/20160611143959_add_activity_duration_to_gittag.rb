class AddActivityDurationToGittag < ActiveRecord::Migration
  def change
    add_column :gittags, :activity_duration, :string
  end
end
