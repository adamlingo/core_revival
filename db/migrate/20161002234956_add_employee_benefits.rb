class AddEmployeeBenefits < ActiveRecord::Migration
  def change
    add_column :employee_benefits, :name, :string
    add_column :employee_benefits, :description, :string
    add_column :employee_benefits, :url, :string
  end
end
