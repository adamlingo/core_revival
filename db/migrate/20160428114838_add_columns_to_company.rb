class AddColumnsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :email, :string
    add_column :companies, :address, :string
    add_column :companies, :city, :string
    add_column :companies, :state, :string
    add_column :companies, :zip, :string
    add_column :companies, :phone_number, :string
    add_column :companies, :federal_id_number, :string
    add_column :companies, :state_wh_number, :string
    add_column :companies, :unemployment_number, :string
    add_column :companies, :processor_name, :string
  end
end
