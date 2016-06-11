class RenameColumnGithashOfGittag < ActiveRecord::Migration
  def change
    rename_column :gittags, :githash, :commit
  end
end
