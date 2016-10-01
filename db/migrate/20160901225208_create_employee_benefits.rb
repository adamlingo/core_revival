class CreateEmployeeBenefits < ActiveRecord::Migration
  def change
    create_table :employee_benefits do |t|
      t.decimal :pto_balance

      t.timestamps null: false
    end
  end
end
