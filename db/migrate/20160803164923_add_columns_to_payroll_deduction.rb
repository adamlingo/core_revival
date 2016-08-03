class AddColumnsToPayrollDeduction < ActiveRecord::Migration
  def change
    add_column :payroll_deductions, :pay_ee_id, :string
    add_column :payroll_deductions, :pay_sub_id, :string
    add_column :payroll_deductions, :pay_sub_name, :string
    add_column :payroll_deductions, :pay_category, :string
    add_column :payroll_deductions, :deduction_amount, :decimal
  end
end
