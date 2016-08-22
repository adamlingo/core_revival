class AddCompanyIdToPayrollPeriodTable < ActiveRecord::Migration
  def change
  add_column :payroll_periods, :company_id, :integer 
  end
  
end
