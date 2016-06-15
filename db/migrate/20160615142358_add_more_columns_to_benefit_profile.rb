class AddMoreColumnsToBenefitProfile < ActiveRecord::Migration
  def change
    add_column :benefit_profiles, :employee_category, :integer
    add_column :benefit_profiles, :benefit_category, :string
    add_column :benefit_profiles, :employer_pay_type, :string
    add_column :benefit_profiles, :benefit_amount, :string
  end
end
