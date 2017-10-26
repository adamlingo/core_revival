class AddBenefitProfileRankToBenefitProfile < ActiveRecord::Migration
  def change
    add_column :benefit_profiles, :benefit_profile_rank, :integer
  end
end
