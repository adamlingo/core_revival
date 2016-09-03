class AddEmployeeCategoryToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :employee_category, :string, null: false
  end
end
