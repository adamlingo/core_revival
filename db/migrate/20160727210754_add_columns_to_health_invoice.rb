class AddColumnsToHealthInvoice < ActiveRecord::Migration
  def change
    add_column :health_invoices, :account_number, :string
    add_column :health_invoices, :billing_profile, :string
    add_column :health_invoices, :category, :integer
    add_column :health_invoices, :product, :string
    add_column :health_invoices, :health_sub_id, :string
    add_column :health_invoices, :sub_name, :string
    add_column :health_invoices, :tier, :string
    add_column :health_invoices, :change_reason, :string
    add_column :health_invoices, :retro_fee_adjustment, :decimal
    add_column :health_invoices, :current_charges, :decimal
    add_column :health_invoices, :total_charges, :decimal
  end
end
