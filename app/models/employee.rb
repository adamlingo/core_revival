require 'csv'

class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  has_many :benefit_profiles, through: :company
  
  
  
    def self.import(file_path)
      # file_path = '/home/ubuntu/workspace/core_redux/lib/assets/EmployeeList.csv'
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


end
