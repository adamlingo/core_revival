class AddAmountToEmployeeBenefitSelection < ActiveRecord::Migration
  def change
  	add_column :employee_benefit_selections, :amount, :decimal
  end
end
