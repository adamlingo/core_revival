class RemoveEmployeeAndAdminFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :employee, :boolean
    remove_column :users, :admin, :boolean
  end
end
