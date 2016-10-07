require 'csv'

class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  # each EE has a UserID
  belongs_to :user
  has_many :benefit_profiles, through: :company
  has_one :employee_additional_login
  
  def display_name
    "#{self.last_name}, #{self.first_name}"
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
                                          dob: import_hash['Birth Date'],
                                          doh: import_hash['Hire Date'])
      import.save!
      end
    end
  end 


end
