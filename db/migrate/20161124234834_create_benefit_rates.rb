class CreateBenefitRates < ActiveRecord::Migration
  def change
    create_table :benefit_rates do |t|

      t.timestamps null: false
      t.integer :benefit_detail_id
      t.integer :age
      t.decimal :rate
    end
  end
end
