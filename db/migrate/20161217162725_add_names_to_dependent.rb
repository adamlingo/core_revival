class AddNamesToDependent < ActiveRecord::Migration
  def change
    add_column :dependents, :first_name, :string
    add_column :dependents, :last_name, :string
  end
end
