class AddEmployeeIdAndBenefitProfileIdToBenefitDetail < ActiveRecord::Migration
  def change
    add_column :benefit_details, :employee_id, :integer
    add_column :benefit_details, :benefit_profile_id, :integer
  end
end
