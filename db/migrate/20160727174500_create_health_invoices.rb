class CreateHealthInvoices < ActiveRecord::Migration
  def change
    create_table :health_invoices do |t|

      t.timestamps null: false
    end
  end
end
