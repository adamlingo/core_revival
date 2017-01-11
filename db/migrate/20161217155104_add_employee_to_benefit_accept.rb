class AddEmployeeToBenefitAccept < ActiveRecord::Migration
  def change
    add_column :benefit_accepts, :employee_id, :integer
  end
end
