class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :title
      t.text :description
      t.string :image_id
      t.string :image_filename
      t.string :image_content_type
      t.integer :image_size

      t.timestamps null: false
    end
  end
end
