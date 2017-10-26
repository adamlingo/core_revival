class AddEmployeeCategoryBackToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :employee_category, :string, null: true, default: "Employee"
  end
end
