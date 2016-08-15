class AddSubIdToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :sub_id, :string
  end
end
