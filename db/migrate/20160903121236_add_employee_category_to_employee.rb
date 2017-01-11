class AddEmployeeCategoryToEmployee < ActiveRecord::Migration
  def change
    unless column_exists?(:employees, :employee_category)
      add_column :employees, :employee_category, :string, null: true
    end
  end
end
