class RemoveDobdohEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :dob, :string
    remove_column :employees, :doh, :string
  end
end
