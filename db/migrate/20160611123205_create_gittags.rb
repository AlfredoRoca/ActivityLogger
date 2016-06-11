class CreateGittags < ActiveRecord::Migration
  def change
    create_table :gittags do |t|
      t.string :hash
      t.datetime :date
      t.string :description

      t.timestamps null: false
    end
  end
end
