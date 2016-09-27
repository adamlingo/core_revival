require 'csv'

class EmployeeAdditionalLogin < ActiveRecord::Base
    belongs_to :employee
    
    
      # Beware duplicate employee names
      def self.import(file_path)
        duplicates = []
        not_found = []
        # file_path = '/home/ubuntu/workspace/core_redux/lib/assets/SwipeclockList.csv'
        CSV.foreach(file_path, headers: true) do |row|
          import_hash = row.to_hash
          unless import_hash['Employee Name'].nil?
            emp_name = import_hash['Employee Name']
            names = emp_name.split(/[\s,]+/)
            last_name = names[0]
            first_name = names[1].sub(/\ /, '')
            last_name = last_name.capitalize
            first_name = first_name.capitalize
     


          
            employee = Employee.where(last_name: last_name,
                                      first_name: first_name)
            if (employee.present? && employee.count > 1)
              duplicates << { :first_name => first_name, :last_name => last_name }
            else
              real_employee = employee.first
              unless real_employee.nil?
                import = find_or_create_by!(swipeclock_ee_id: import_hash['Employee Code'],
                                            employee_id: real_employee.id,
                                            subscriber_id: real_employee.sub_id)
                import.save!
              else 
                not_found << { :first_name => first_name, :last_name => last_name }
              end
              
            end
          end
        end
        
        if duplicates.count > 0
          # do something smart with the duplicate record data so a human can look and update the Employee records manually
          puts "DUPLICATES"
          puts duplicates
        end
        if not_found.count > 0
          # do something smart with the not found record data so a human can look and update the Employee records manually
          puts "NOT FOUND"
          puts not_found
        end
    
      end 
end
