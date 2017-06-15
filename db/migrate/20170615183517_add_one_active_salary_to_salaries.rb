class AddOneActiveSalaryToSalaries < ActiveRecord::Migration
  def change
  	add_index :salaries, [:employee_id], unique: true, where: 'end_date IS NULL'
  end
end
