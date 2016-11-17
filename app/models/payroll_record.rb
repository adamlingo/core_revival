require 'csv'

class PayrollRecord < ActiveRecord::Base
  belongs_to :companies
  has_one :employee
  
  def self.save
    
  
  end
  
  def self.to_csv
    attributes = %w{company_id employee_id reg_hours ot_hours other_pay sick_hours vacation_hours holiday_hours memo updated_at}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      
      all.each do |payroll_record|
        csv << payroll_record.attributes.values_at(*attributes)
      end
      
    end
  
  
  end
 
end
