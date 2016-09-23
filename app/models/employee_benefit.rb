class EmployeeBenefit < ActiveRecord::Base
    belongs_to :employee
    
    def self.import(raw_data)
        CSV.parse(raw_data, headers: true) do |row|
          pto_hash = row.to_hash
          pto_balance = find_or_create_by!(employee.employee_additional_login.swipeclock_ee_id: pto_hash['EE Code'],
                                         pto_balance: pto_hash['Ending Balance'])
          pto_balance.save!
        end
    end
end
