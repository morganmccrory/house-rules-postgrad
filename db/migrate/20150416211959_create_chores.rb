class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :task
      t.references :house, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
