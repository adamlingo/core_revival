class AddEeNamesToPayrollRecord < ActiveRecord::Migration
  def change
    add_column :payroll_records, :first_name, :string
    add_column :payroll_records, :last_name, :string
  end
end
