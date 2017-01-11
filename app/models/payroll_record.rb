require 'csv'

class PayrollRecord < ActiveRecord::Base
  belongs_to :companies
  has_one :employee
  
  validates_presence_of :company_id
  validates_presence_of :employee_id
  
  def self.save
    
  
  end
  
  def self.to_csv
    attributes = %w{export_id company_id employee_id reg_hours ot_hours other_pay sick_hours vacation_hours holiday_hours memo updated_at}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      
      all.each do |payroll_record|
        csv << payroll_record.attributes.values_at(*attributes)
      end
      
    end
  
  
  end
 
end
