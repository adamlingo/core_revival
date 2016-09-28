class EmployeeBenefit < ActiveRecord::Base
    belongs_to :employee
    
    def employee_name
        
        emp = Employee.find_by(id: self.employee_id)
        if emp.nil?
            "#{ self.ee_id }, #{ self.employee_id }"
        else
            "#{ emp.last_name }, #{ emp.first_name }"
        end
    end
    
    def self.update_employee_id
    
        EmployeeBenefit.all.each { |employee_benefit|
            additional_login = EmployeeAdditionalLogin.find_by(swipeclock_ee_id: employee_benefit.ee_id)
            if additional_login.present?
                employee_benefit.employee_id = additional_login.employee_id
                employee_benefit.save!
            end
            
        }
    end
    
    
    
    def self.import(raw_data)

        CSV.parse(raw_data, headers: true) do |row|
          pto_hash = row.to_hash
            
            if pto_hash['Type'] == 'PTO'
                employee_benefit = find_or_create_by!(ee_id: pto_hash['EE Code'])
                
                employee_benefit.pto_balance = pto_hash['Ending Balance'].round(1)
                employee_benefit.save!
            else
            end
        end
    end
end
