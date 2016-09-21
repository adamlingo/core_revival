class AddEeidToEmployeeBenefits < ActiveRecord::Migration
  def change
    add_column :employee_benefits, :employee_id, :string
  end
end
