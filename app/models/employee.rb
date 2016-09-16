class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  has_many :benefit_profiles, through: :company

  def self.save_pto(company_id, raw_data)
  	puts "company_id: #{company_id}\nraw_data:\n#{raw_data}"

  	# do the work...
  	# parse the raw_data

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      pto_hash = row.to_hash
      # all columns in Payroll Deduction csv
      unless pto_hash['Employee ID'].nil?
        pto_amount = find_or_create_by!(pay_ee_id: payroll_hash['Employee ID'],
                                            # pay_sub_name: payroll_hash['Employee Name'],
                                            # pay_sub_id: payroll_hash['Subscriber  #'],
                                            # pay_category: payroll_hash['Category#'],
                                            deduction_amount: payroll_hash['Amount'])
        payroll_deduction.save!
      end
    end
  end
  	# look up the Employee
  	# add/update the PTO balance for that employee
  end
end
