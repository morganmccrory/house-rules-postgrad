class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :title
      t.datetime :start
      t.datetime :end
      t.boolean :all_day
      t.boolean :overlap
      t.string :description
      t.references :house, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
