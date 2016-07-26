class AddTier < ActiveRecord::Migration
  def change
     add_column :benefit_details, :employee_tier, :string

  end
end
