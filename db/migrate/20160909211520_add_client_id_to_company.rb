class AddClientIdToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :client_id, :string
  end
end
