class AddColumnsToBenefitProfile < ActiveRecord::Migration
  def change
    add_column :benefit_profiles, :provider, :string
    add_column :benefit_profiles, :provider_plan, :string
    add_column :benefit_profiles, :type, :string
  end
end
