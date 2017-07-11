class CreateLifeBenefitDetails < ActiveRecord::Migration
  def change
    create_table :life_benefit_details do |t|
      t.integer :benefit_detail_id
      t.decimal :subscriber_cap
      t.integer :subscriber_increment
      t.decimal :spouse_cap
      t.integer :spouse_increment
      t.decimal :dependent_coverage
      t.decimal :dependent_rate

      t.timestamps null: false
    end
  end
end
