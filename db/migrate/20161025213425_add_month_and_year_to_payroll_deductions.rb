class AddMonthAndYearToPayrollDeductions < ActiveRecord::Migration
  def change
    add_column :payroll_deductions, :month, :integer
    add_column :payroll_deductions, :year, :integer
  end
end
