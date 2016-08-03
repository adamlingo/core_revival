class AddPayFrequency < ActiveRecord::Migration
  def change
    add_column :companies, :pay_frequency, :string
    
  end
end
