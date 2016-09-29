class CreateEmployeeAdditionalLogins < ActiveRecord::Migration
  def change
    create_table :employee_additional_logins do |t|
      
      t.string :subscriber_id
      t.string :name
      t.string :swipeclock_ee_id
      t.string :name
      

      t.timestamps null: false
    end
  end
end
