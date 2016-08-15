class RemoveCompanyPayrollDateTable < ActiveRecord::Migration
  def change
    drop_table :company_payroll_dates
  end
end
