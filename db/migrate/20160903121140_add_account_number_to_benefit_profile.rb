class AddAccountNumberToBenefitProfile < ActiveRecord::Migration
  def change
    add_column :benefit_profiles, :account_number, :string, null: false
  end
end
