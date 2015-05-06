class CreateChoreLogs < ActiveRecord::Migration
  def change
    create_table :chore_logs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :chore, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
