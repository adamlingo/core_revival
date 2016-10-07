class RemoveEmployeeCategory < ActiveRecord::Migration
  def up
    if column_exists?(:employees, :employee_category)
      remove_column :employees, :employee_category, :string
    end
  end
  def down
    unless column_exists?(:employees, :employee_category)
      add_column :employees, :employee_category, :string
    end
  end
end
