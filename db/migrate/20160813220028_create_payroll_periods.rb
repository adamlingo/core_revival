class CreatePayrollPeriods < ActiveRecord::Migration
  def change
    create_table :payroll_periods do |t|

      t.timestamps null: false
    end
  end
end
