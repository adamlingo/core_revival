class AddBenefitMethodToBenefitProfile < ActiveRecord::Migration
  def change
    add_column :benefit_profiles, :benefit_method, :string
  end
end
