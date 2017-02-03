class BenefitRate < ActiveRecord::Base
    belongs_to :benefit_detail
    validates_presence_of :benefit_detail_id
    
    def new
    end
    
    def self.compute_rate(employee_id, benefit_detail_id, effective_date)
        
        benefit_detail = BenefitDetail.find(benefit_detail_id)
        employee = Employee.find(employee_id)
        # if employee is eligible
        if employee.benefit_eligible == true
            ee_dob = employee.date_of_birth            
            
            # need month and day in calculation
            ee_age = effective_date.year - ee_dob.year 
             
             puts "Employee Age #{ee_age}"
             puts "Effective Date #{effective_date}"
             
            benefit_rate = BenefitRate.find_by(age: ee_age, benefit_detail_id: benefit_detail_id)
            
            ee_rate = benefit_rate.rate
            puts ee_rate

        # take employee dob and compute age
        
        # look up rate from table
        end

        return ee_rate
    end
    
    def self.import(benefit_detail_id, file_path)
       # file_path = '/home/ubuntu/workspace/core_redux/test/fixtures/BCBS_G712PFR.csv'
        CSV.foreach(file_path, headers: true) do |row|
           import_hash = row.to_hash
           unless import_hash['Age'].nil?
                import = find_or_create_by!(age: import_hash['Age'],
                                            benefit_detail_id: benefit_detail_id,
                                            rate: import_hash['Rate'])
            import.save!
           end
        end
    end
    
end
