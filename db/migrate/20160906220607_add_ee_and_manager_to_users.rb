class AddEeAndManagerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :employee, :boolean, default: false
    add_column :users, :manager, :boolean, default: false
  end
end
