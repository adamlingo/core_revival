class AddColumnToLifeBenefitDetail < ActiveRecord::Migration
  def change
  	add_column :life_benefit_details, :base_coverage, :integer
  end
end
