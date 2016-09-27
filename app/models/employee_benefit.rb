class EmployeeBenefit < ActiveRecord::Base
    belongs_to :employee
    
    def self.import(raw_data)

        CSV.parse(raw_data, headers: true) do |row|
          pto_hash = row.to_hash
            
            if pto_hash['Type'] == 'PTO'
                employee_benefit = find_or_create_by!(ee_id: pto_hash['EE Code'])
                
                employee_benefit.pto_balance = pto_hash['Ending Balance']
                employee_benefit.save!
            else
            end
        end
    end
end
