class AddFieldsToPayrollPeriod < ActiveRecord::Migration
  def change
    add_column :payroll_periods, :pay_period, :string
    add_column :payroll_periods, :year, :integer
    add_column :payroll_periods, :month, :integer
    add_column :payroll_periods, :day, :integer
  end
end
