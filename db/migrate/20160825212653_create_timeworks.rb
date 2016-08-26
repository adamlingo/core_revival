class CreateTimeworks < ActiveRecord::Migration
  def change
    create_table :timeworks do |t|


      t.timestamps null: false
    end
  end
end
