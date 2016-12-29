class CreateEmployeeFolders < ActiveRecord::Migration
  def change
    create_table :employee_folders do |t|
      t.integer :employee_id, null: false
      t.integer :folder_id, null: false
      t.timestamps null: false
    end
    add_foreign_key :employee_folders, :folders
    add_foreign_key :employee_folders, :employees
  end
end
