class BenefitRate < ActiveRecord::Base
  belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id
  
  # COMPUTE BENEFIT RATES
  def self.compute_employee_rate(employee_id, employee_benefit_selection_id)
    ee_selection = EmployeeBenefitSelection.find(employee_benefit_selection_id)
    benefit_detail = BenefitDetail.find(ee_selection.benefit_detail_id)
    employee = Employee.find(employee_id)
    effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
    if employee.benefit_eligible == true
      ee_dob = employee.date_of_birth
      ee_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob), benefit_detail_id: benefit_detail.id)
      ee_rate = ee_benefit_rate.rate - compute_employer_contribution_for_employee(benefit_detail, ee_benefit_rate.rate)
      ee_rate
    else
      0
    end
  end  

  def self.compute_employee_spouse_rate(employee_id, employee_benefit_selection_id)
    ee_selection = EmployeeBenefitSelection.find(employee_benefit_selection_id)
    benefit_detail = BenefitDetail.find(ee_selection.benefit_detail_id)
    employee = Employee.find(employee_id)
    spouse = Dependent.find_by(employee_id: employee.id, relationship: "spouse")
    effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
    if employee.benefit_eligible == true
      ee_dob = employee.date_of_birth
      spouse_dob = spouse.date_of_birth
      ee_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob), benefit_detail_id: benefit_detail.id)
      sps_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, spouse_dob), benefit_detail_id: benefit_detail.id)
      ee_sps_rate = (ee_benefit_rate.rate - compute_employer_contribution_for_employee(benefit_detail, ee_benefit_rate.rate)) + (sps_benefit_rate.rate - compute_employer_contribution_for_spouse(benefit_detail, sps_benefit_rate.rate))
      ee_sps_rate
    else
      0
    end
  end

  def self.compute_employee_spouse_plus_one_rate(employee_id, employee_benefit_selection_id)
    ee_selection = EmployeeBenefitSelection.find(employee_benefit_selection_id)
    benefit_detail = BenefitDetail.find(ee_selection.benefit_detail_id)
    effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
    employee = Employee.find(employee_id)
    spouse = Dependent.find_by(employee_id: employee.id, relationship: "spouse")
    dependents_by_age = Dependent.where(employee_id: employee.id, relationship: "dependent")
    dependents = dependents_by_age.select{|d| effective_age(effective_date, d.date_of_birth) < 26 }
    dependents.sort_by{|dep| [dep.date_of_birth]}.reverse
    oldest_dependent = dependents.first
    puts "******************"
    puts dependents
    puts "Oldest Dependent: ", oldest_dependent.first_name, oldest_dependent.last_name
    puts "******************"
    if employee.benefit_eligible == true
      ee_dob = employee.date_of_birth
      spouse_dob = spouse.date_of_birth
      dep_dob = oldest_dependent.date_of_birth
      ee_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob), benefit_detail_id: benefit_detail.id)
      sps_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, spouse_dob), benefit_detail_id: benefit_detail.id)
      dep_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, dep_dob), benefit_detail_id: benefit_detail.id)
      ee_sps_plus_one_rate = (ee_benefit_rate.rate - compute_employer_contribution_for_employee(benefit_detail, ee_benefit_rate.rate)) + (sps_benefit_rate.rate - compute_employer_contribution_for_spouse(benefit_detail, sps_benefit_rate.rate))
      ee_sps_plus_one_rate
    else
      0
    end
  end

  def self.compute_employee_dependent_rate(employee_id, employee_benefit_selection_id)
    675.32
  end

  def self.compute_employee_dependent_plus_one_rate(employee_id, employee_benefit_selection_id)
    899.12
  end  

  # EMPLOYER CONTRIBUTION METHODS
  def self.compute_employer_contribution_for_employee(benefit_detail, benefit_rate)
    if benefit_detail.benefit_method == 'FIXED'
      benefit_detail.category_sub
    else
      benefit_detail.category_sub * benefit_rate  
    end
  end

  def self.compute_employer_contribution_for_spouse(benefit_detail, benefit_rate)
    if benefit_detail.benefit_method == 'FIXED'
      benefit_detail.category_sps
    else
      benefit_detail.category_sps * benefit_rate  
    end
  end

  def self.compute_employer_contribution_for_dependent(benefit_detail, benefit_rate)
    if benefit_detail.benefit_method == 'FIXED'
      benefit_detail.category_dep
    else
      benefit_detail.category_dep * benefit_rate  
    end
  end

  # effective age
  def self.effective_age(effective_date, dob)
    # PUTS STATEMENTS FOR TERMINAL CHILLNESS
    puts "effective_date ====== #{effective_date}"
    puts "DOB of ee ====== #{dob}"
    # calculate current age of ee
    age = Date.today.year - dob.year
    age -= 1 if Date.today < dob + age.years
    puts "AGE of ee ====== #{age}"
    # calculate age of ee on effective date of Benefit Profile
    effective_age = effective_date.year - dob.year
    effective_age -= 1 if effective_date < dob + effective_age.years
    puts "EFFECTIVE_AGE of ee ====== #{effective_age}"
    # return age of EE on the effective date of the Benefit Profile
    effective_age
  end

  def self.find_one_dependent(dep_dob)

  end

  def self.find_two_dependents()

  end
  
  # Import rate/age table
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
