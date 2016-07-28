class AddMonthAndYearToHealthInvoice < ActiveRecord::Migration
  def change
    add_column :health_invoices,  :month, :integer
    add_column :health_invoices,  :year,  :integer
  end
end
