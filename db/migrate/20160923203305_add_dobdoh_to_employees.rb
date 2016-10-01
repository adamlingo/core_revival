class AddDobdohToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :dob, :string 
    add_column :employees, :doh, :string
  end
end
