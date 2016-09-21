class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  has_many :benefit_profiles, through: :company

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
