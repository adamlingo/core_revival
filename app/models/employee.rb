require 'csv'

class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  has_many :benefit_profiles, through: :company
  has_many :salaries
  has_many :employee_benefits
  has_many :employee_benefit_selections
  has_many :payroll_records
  has_one :employee_additional_login
  has_many :dependents


  validates :email, presence:true, uniqueness: true
  # validates :ssn, uniqueness: true
  validates_presence_of :company_id
  
  # Depreciated encryption gem/method 
  # attr_encrypted :ssn, key: :get_encryption_key

  def current_benefit_selection_by_profile_id(benefit_profile_id)
    selection = EmployeeBenefitSelection.find_by(employee_id: id, benefit_detail_id: BenefitDetail.where(benefit_profile_id: benefit_profile_id).to_a)
    selection
  end

  # def get_encryption_key
  #   ENV['ENCRYPTION_KEY']
  # end
 
  def display_name
    "#{self.last_name}, #{self.first_name}"
  end
  
  def current_salary
    self.salaries.where(end_date: nil).first
  end

  def self.import(company_id, file_path)
    # file_path = '/home/ubuntu/workspace/core_redux/lib/assets/EmployeeList.csv'
    CSV.foreach(file_path, headers: true) do |row|
      import_hash = row.to_hash
      unless import_hash['First Name'].nil?
        combined_name = import_hash['First Name']
        names = combined_name.split(' ')
        first_name = names[0] 
        import = find_or_create_by!(first_name: first_name.capitalize,
                                    last_name: import_hash['Last Name'].capitalize,
                                    company_id: company_id,
                                    address: import_hash['Home Address'],
                                    date_of_birth: import_hash['Birth Date'],
                                    date_of_hire: import_hash['Hire Date'])
        import.save!
      end
    end
  end
end
