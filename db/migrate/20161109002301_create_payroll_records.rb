class CreatePayrollRecords < ActiveRecord::Migration
  def change
    create_table :payroll_records do |t|
      t.integer :company_id
      t.integer :employee_id
      t.decimal :reg_hours
      t.decimal :ot_hours
      t.decimal :other_pay
      t.decimal :sick_hours
      t.decimal :vacation_hours
      t.decimal :holiday_hours
      t.text  :memo
      t.timestamps null: false
    end
  end
end
