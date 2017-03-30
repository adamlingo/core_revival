class BenefitRate < ActiveRecord::Base
  belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id
  
  def new
  end
  
  def self.compute_rates(employee_id, benefit_detail_id, effective_date)
    benefit_detail = BenefitDetail.find(benefit_detail_id)
    employee = Employee.find(employee_id)
    # if employee is eligible
    if employee.benefit_eligible == true
      ee_dob = employee.date_of_birth
      # call ee_age to calculate age based on eff. date 
      ee_benefit_rate = BenefitRate.find_by(age: ee_age(effective_date, ee_dob), benefit_detail_id: benefit_detail_id)
      
      ee_rate = ee_benefit_rate.rate - compute_employer_contribution_for_employee(benefit_detail, ee_benefit_rate.rate)
      # check terminal/console if you want to see rate locally
      puts ee_rate
      sps_rate = 0 #compute rate for spouse
      dep_rate = 0 #compute dependent rate
      return ee_rate + sps_rate + dep_rate 
    else
      # perhaps useful?
      return "Benefit Declined, no rate"
    end     
  end

  def self.compute_employer_contribution_for_employee(benefit_detail, benefit_rate)
    if benefit_detail.benefit_method == 'FIXED'
      benefit_detail.category_sub
    else
      benefit_detail.category_sub * benefit_rate  
    end

  end

  def self.compute_employer_contribution_for_dependent(benefit_detail, benefit_rate)
    if benefit_detail.benefit_method == 'FIXED'
      benefit_detail.category_sub
    else
      benefit_detail.category_sub * benefit_rate  
    end
  end

  def self.ee_age(effective_date, ee_dob)
    # PUTS STATEMENTS FOR TERMINAL CHILLNESS
    puts "effective_date ====== #{effective_date}"
    puts "DOB of ee ====== #{ee_dob}"
    # calculate current age of ee
    age = Date.today.year - ee_dob.year
    age -= 1 if Date.today < ee_dob + age.years
    puts "AGE of ee ====== #{age}"
    # calculate age of ee on effective date of Benefit Profile
    effective_age = effective_date.year - ee_dob.year
    effective_age -= 1 if effective_date < ee_dob + effective_age.years
    puts "EFFECTIVE_AGE of ee ====== #{effective_age}"
    # return age of EE on the effective date of the Benefit Profile
    return effective_age
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
