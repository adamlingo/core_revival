class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|

      t.timestamps null: false
      t.integer :employee_id
      t.date :start_date
      t.date :end_date
      t.decimal :rate
      t.string :type
    end
  end
end
