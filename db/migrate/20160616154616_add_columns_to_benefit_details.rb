class AddColumnsToBenefitDetails < ActiveRecord::Migration
  def change
    add_column :benefit_details, :employee_category, :string
    add_column :benefit_details, :benefit_category, :string
    add_column :benefit_details, :benefit_method, :string
    add_column :benefit_details, :benefit_amount, :string
  end
end
