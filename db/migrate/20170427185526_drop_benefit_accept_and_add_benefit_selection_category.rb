class DropBenefitAcceptAndAddBenefitSelectionCategory < ActiveRecord::Migration
  def up
  	remove_column :employee_benefit_selections, :benefit_accept
  	add_column :employee_benefit_selections, :benefit_selection_category_id, :integer, null: true
  	add_foreign_key :employee_benefit_selections, :benefit_selection_categories
  end

  def down
  	add_column :employee_benefit_selections, :benefit_accept, :boolean
  	remove_foreign_key :employee_benefit_selections, :benefit_selection_categories
  	remove_column :employee_benefit_selections, :benefit_selection_category_id
  end
end
