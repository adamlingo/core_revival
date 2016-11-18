class AddExportIdPayrollRecrd < ActiveRecord::Migration
  def change
    add_column :payroll_records, :export_id, :string
  end
end
