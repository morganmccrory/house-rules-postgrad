class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip_code
      t.references :addressable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
