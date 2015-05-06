class CreateHousingAssignments < ActiveRecord::Migration
  def change
    create_table :housing_assignments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :house, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
