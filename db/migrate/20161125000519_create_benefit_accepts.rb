class CreateBenefitAccepts < ActiveRecord::Migration
  def change
    create_table :benefit_accepts do |t|
      
      t.boolean :accept
      t.integer :benefit_profile_id
      t.timestamps null: false
    end
  end
end
