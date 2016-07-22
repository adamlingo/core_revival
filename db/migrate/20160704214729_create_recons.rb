class CreateRecons < ActiveRecord::Migration
  def change
    create_table :recons do |t|

      t.timestamps null: false
    end
  end
end
