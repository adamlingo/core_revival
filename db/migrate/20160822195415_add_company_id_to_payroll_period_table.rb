class AddCompanyIdToPayrollPeriodTable < ActiveRecord::Migration
  def change
  add_column :payroll_periods, :company_id, :integer unless column_exists?(:payroll_periods, :company_id)
  end
  
end
