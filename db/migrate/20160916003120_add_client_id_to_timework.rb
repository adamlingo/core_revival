class AddClientIdToTimework < ActiveRecord::Migration
  def change
     add_column :timeworks, :client_id, :string
     remove_column :companies, :client_id, :string
  end
end
