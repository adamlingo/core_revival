class AddForeignKey < ActiveRecord::Migration
  def change
    
    add_foreign_key :salaries, :employees
    
  end
end
