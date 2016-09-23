require 'csv'

class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  has_many :benefit_profiles, through: :company
  
  
  
    def self.import(file_path)
      file_path = 'home/ubuntu/workspace/core_redux/lib/assets/EmployeeList.csv'
      CSV.foreach(file_path, headers: true) do |row|
        import_hash = row.to_hash
        unless import_hash['First Name'].nil?
          import = find_or_create_by!(first_name: import_hash['First Name'],
                                            last_name: import_hash['Last Name'],
                                            address: import_hash['Home Address'],
                                            dob: import_hash['Birth Date'],
                                            doh: import_hash['Hire Date'])
        import.save!
        end
    end
    
    end 

  # def self.save_pto(company_id, raw_data)
  # 	puts "company_id: #{company_id}\nraw_data:\n#{raw_data}"
  # end
  # 	# do the work...
  # 	# parse the raw_data

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     pto_hash = row.to_hash
  #     # all columns in Payroll Deduction csv
  #     unless pto_hash['EE Code'].nil?
  #       	# look up the Employee
  #       pto_amount = find_or_create_by!(employee_benefits.ee_id: pto_hash['EE Code'],
  #                                     employee_benefits.pto_balance: payroll_hash['Ending Balance'])
  #     	# add/update the PTO balance for that employee
  #       pto_amount.save!
  #     end
  #   end
  # end
  
  


end
