class ChangeDataTypeForEmployees < ActiveRecord::Migration
  
  def change
    
  add_column :employees, :date_of_birth, :date 
  add_column :employees, :date_of_hire, :date
  
  end

end
