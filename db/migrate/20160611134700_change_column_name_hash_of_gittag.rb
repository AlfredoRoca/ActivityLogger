class ChangeColumnNameHashOfGittag < ActiveRecord::Migration
  def change
    rename_column :gittags, :hash, :githash
  end
end
