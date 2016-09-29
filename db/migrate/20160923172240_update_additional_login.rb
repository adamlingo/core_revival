class UpdateAdditionalLogin < ActiveRecord::Migration
  def change
    add_column :employee_additional_logins, :employee_id, :integer
    remove_column :employee_additional_logins, :name, :string
  end
end
