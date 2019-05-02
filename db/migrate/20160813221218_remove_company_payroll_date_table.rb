class RemoveCompanyPayrollDateTable < ActiveRecord::Migration
  def change
    table_exists?(:company_payroll_date_table) ? drop_table(:company_payroll_date_table) : nil
  end
end