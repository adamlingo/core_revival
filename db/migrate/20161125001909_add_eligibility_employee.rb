class AddEligibilityEmployee < ActiveRecord::Migration
  def change
    
    add_column :employees, :benefit_eligible, :boolean
    
  end
end
