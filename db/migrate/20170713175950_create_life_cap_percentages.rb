class CreateLifeCapPercentages < ActiveRecord::Migration
  def change
    create_table :life_cap_percentages do |t|
      t.integer :life_benefit_detail_id
      t.integer :age
      t.decimal :cap_percentage

      t.timestamps null: false
    end
  end
end
