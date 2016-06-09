class CreateBenefitProfiles < ActiveRecord::Migration
  def change
    create_table :benefit_profiles do |t|
      t.string :name
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
