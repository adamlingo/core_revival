class EmployeeBenefit < ActiveRecord::Base
    belongs_to :employee
    
    def self.import
        CSV.foreach(raw_data, headers: true) do |row|
          pto_hash = row.to_hash
          pto_balance = find_or_create_by!(ee_id: pto_hash['EE Code'],
                                         end_balance: pto_hash['Ending Balance'])
          pto_balance.save!
    end
end
