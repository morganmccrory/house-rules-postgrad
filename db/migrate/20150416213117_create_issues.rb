class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :reason
      t.references :user, index: true, foreign_key: true
      t.references :issuable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
