class CreateBenefitDetails < ActiveRecord::Migration
  def change
    create_table :benefit_details do |t|

      t.timestamps null: false
    end
  end
end
