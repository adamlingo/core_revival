class DependentsToBenefitProfile < ActiveRecord::Migration
  def change
    add_column :benefit_profiles, :spouse_eligible, :boolean
    add_column :benefit_profiles, :child_eligible, :boolean
  end
end
