class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.belongs_to :author
      t.references :house, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
