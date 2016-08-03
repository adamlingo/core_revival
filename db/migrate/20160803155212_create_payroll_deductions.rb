class CreatePayrollDeductions < ActiveRecord::Migration
  def change
    create_table :payroll_deductions do |t|

      t.timestamps null: false
    end
  end
end
