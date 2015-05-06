class CreateUserPromises < ActiveRecord::Migration
  def change
    create_table :user_promises do |t|
      t.boolean :fulfilled, default: false
      t.references :user, index: true, foreign_key: true
      t.references :promisable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
