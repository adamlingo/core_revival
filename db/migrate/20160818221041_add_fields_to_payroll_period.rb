class AddFieldsToPayrollPeriod < ActiveRecord::Migration
  def change
    add_column :payroll_periods, :pay_period, :string unless column_exists?(:payroll_periods, :pay_period)
    add_column :payroll_periods, :year, :integer unless column_exists?(:payroll_periods, :year)
    add_column :payroll_periods, :month, :integer unless column_exists?(:payroll_periods, :month)
    add_column :payroll_periods, :day, :integer unless column_exists?(:payroll_periods, :day)
  end
end
