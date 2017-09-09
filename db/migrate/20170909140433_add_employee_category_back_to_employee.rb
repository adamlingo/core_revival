class AddEmployeeCategoryBackToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :employee_category, :string
  end
end
