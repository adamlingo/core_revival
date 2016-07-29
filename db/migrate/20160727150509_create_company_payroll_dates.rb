class CreateCompanyPayrollDates < ActiveRecord::Migration
  def change
    create_table :company_payroll_dates do |t|
      t.string :year
      t.string :pay_period
      t.timestamps null: false
    end
    
    add_column :companies, :id, :string
  end
end
