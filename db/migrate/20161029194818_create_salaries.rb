class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|

      t.timestamps null: false
      t.integer :employee_id, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.decimal :rate, null: false
      t.string :pay_type, null: false
    end
  end
end
