class AddBenefitAcceptToEmployeeBenefitSelection < ActiveRecord::Migration
  def change
    add_column :employee_benefit_selections, :benefit_accept, :boolean
  end
end
