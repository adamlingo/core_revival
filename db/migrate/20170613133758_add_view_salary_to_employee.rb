class AddViewSalaryToEmployee < ActiveRecord::Migration
  def change
  	add_column :employees, :view_salary, :boolean, null: false, default: true
  end
end
