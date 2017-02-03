require 'csv'

class PayrollRecord < ActiveRecord::Base
  belongs_to :companies
  belongs_to :employee
  
  validates_presence_of :company_id
  validates_presence_of :employee_id
  
  def self.save
    
  
  end
  
  # def employee
  #   Employee.find_by(id: employee_id)
  # end

  def employee_name_first
 	  employee.first_name
 	end
  
  def employee_name_last
    employee.last_name
  end
  
  def self.to_csv
    attributes = %w{export_id company_id employee_name_first employee_name_last reg_hours ot_hours other_pay sick_hours vacation_hours holiday_hours memo updated_at}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      
      all.each do |payroll_record|
        #csv << payroll_record.attributes.values_at(*attributes)
        csv << "#{payroll_record.export_id},#{payroll_record.company_id},#{payroll_record.employee_name_first},#{payroll_record.employee_name_last},#{payroll_record.reg_hours},#{payroll_record.ot_hours},#{payroll_record.other_pay},#{payroll_record.sick_hours},#{payroll_record.vacation_hours},#{payroll_record.holiday_hours},#{payroll_record.memo},#{payroll_record.updated_at}".split(',')
      end
      
    end
  
  
  end
 
end
