class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  has_many :benefit_profiles, through: :company

  def self.save_pto(company_id, raw_data)
  	puts "company_id: #{company_id}\nraw_data:\n#{raw_data}"

  	# do the work...
  	# parse the raw_data
  	# look up the Employee
  	# add/update the PTO balance for that employee
  end
end
