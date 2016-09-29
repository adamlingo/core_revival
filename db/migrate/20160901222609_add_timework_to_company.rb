class AddTimeworkToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :timework_id, :string
    add_column :companies, :timework_pass, :string
  end
end
