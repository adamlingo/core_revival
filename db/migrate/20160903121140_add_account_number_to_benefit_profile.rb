class AddAccountNumberToBenefitProfile < ActiveRecord::Migration
  def change
    unless column_exists?(:benefit_profiles, :account_number)
      add_column :benefit_profiles, :account_number, :string, null: true
    end
  end
end
