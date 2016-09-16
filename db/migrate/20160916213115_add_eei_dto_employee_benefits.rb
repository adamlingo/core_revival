class AddEeiDtoEmployeeBenefits < ActiveRecord::Migration
  def change
    add_column :employee_benefits, :ee_id, :string
  end
end
