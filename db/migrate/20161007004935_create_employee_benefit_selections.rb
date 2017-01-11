class CreateEmployeeBenefitSelections < ActiveRecord::Migration
  def change
    create_table :employee_benefit_selections do |t|
      t.integer :employee_id, null: false
      t.string :benefit_type, null: false
      t.boolean :decline_benefit, default: false, null: false
      t.integer :benefit_detail_id

      t.timestamps null: false
    end
  end
end
