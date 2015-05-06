class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :alert
      t.string :category
      t.integer :house_id

      t.timestamps null: false
    end
  end
end
