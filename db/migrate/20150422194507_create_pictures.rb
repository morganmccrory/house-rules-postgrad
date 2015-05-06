class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.attachment :picture_content
      t.belongs_to :message

      t.timestamps null: false
    end
  end
end
