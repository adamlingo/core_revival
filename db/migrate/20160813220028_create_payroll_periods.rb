class CreatePayrollPeriods < ActiveRecord::Migration
  def change
  	unless PayrollPeriod.table_exists?
        create_table :payroll_periods do |t|

          t.timestamps null: false
        end
    end
  end
end
