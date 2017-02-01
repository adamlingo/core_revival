class AddDateToBenefitProfile < ActiveRecord::Migration
  def change
    add_column :benefit_profiles, :effective_date, :date
  end
end
