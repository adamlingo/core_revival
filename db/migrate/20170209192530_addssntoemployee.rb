class Addssntoemployee < ActiveRecord::Migration
  def change
    add_column :employees, :ssn, :string
  end
end
