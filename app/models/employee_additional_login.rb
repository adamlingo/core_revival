require 'csv'

class EmployeeAdditionalLogin < ActiveRecord::Base
    belongs_to :employee
    
      def self.import(file_path)
      # file_path = '/home/ubuntu/workspace/core_redux/lib/assets/EmployeeList.csv'
      CSV.foreach(file_path, headers: true) do |row|
        import_hash = row.to_hash
        unless import_hash['Employee Name'].nil?
          import = find_or_create_by!(swipeclock_ee_id: import_hash['Employee Code'],
                                     employee_id: import_hash['Last Name'])
        import.save!
        end
        end
    
      end 
end
