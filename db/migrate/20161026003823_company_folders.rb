class CompanyFolders < ActiveRecord::Migration
  def change
    create_table :company_folders do |t|
      t.integer :company_id, null: false
      t.integer :folder_id, null: false
      t.timestamps null: false
    end
    add_foreign_key :company_folders, :folders
    add_foreign_key :company_folders, :companies
  end
end
