class AddProjectToGittag < ActiveRecord::Migration
  def change
    add_reference :gittags, :project, index: true, foreign_key: true
  end
end
