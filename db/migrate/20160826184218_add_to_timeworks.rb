class AddToTimeworks < ActiveRecord::Migration
  def change
    
      add_column :timeworks, :company_id, :integer
      add_column :timeworks, :user_id, :string
      add_column :timeworks, :password, :string
      add_column :timeworks, :secondFactor, :string
      
  end
end
