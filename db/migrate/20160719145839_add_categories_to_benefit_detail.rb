class AddCategoriesToBenefitDetail < ActiveRecord::Migration
  def change
    add_column :benefit_details, :category_sub, :decimal
    add_column :benefit_details, :category_dep, :decimal
    add_column :benefit_details, :category_sps, :decimal
    add_column :benefit_details, :category_ch_pls_one, :decimal
    add_column :benefit_details, :category_sps_pls_one, :decimal
  end
end
