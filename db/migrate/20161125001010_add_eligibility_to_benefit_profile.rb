class AddEligibilityToBenefitProfile < ActiveRecord::Migration
  def change
    
    add_column :benefit_profiles, :eligibility_days, :integer
    
  end
end
