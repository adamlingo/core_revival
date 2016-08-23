class RemoveEmployeeIdFromBenefitDetail < ActiveRecord::Migration
  def change
    remove_column :benefit_details, :employee_id, :integer
  end
end
