class MedicalBenefitRate < ActiveRecord::Base
  belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id
  
  # COMPUTE BENEFIT RATES (MEDICAL)
  def self.compute_employee_rate(employee_id, benefit_detail)
    effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
    employee = Employee.find(employee_id)
    if employee.benefit_eligible == true
      ee_dob = employee.date_of_birth
      ee_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      ee_rate = ee_benefit_rate.rate - compute_employer_contribution_for_employee(benefit_detail, ee_benefit_rate.rate)
      ee_rate
    else
      0
    end
  end  

  def self.compute_employee_spouse_rate(employee_id, benefit_detail)
    effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
    employee = Employee.find(employee_id)
    spouse = Dependent.find_by(employee_id: employee.id, relationship: "spouse")
    if employee.benefit_eligible == true
      ee_dob = employee.date_of_birth
      spouse_dob = spouse.date_of_birth
      ee_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      sps_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, spouse_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      ee_sps_rate = (ee_benefit_rate.rate - compute_employer_contribution_for_employee(benefit_detail, ee_benefit_rate.rate)) + (sps_benefit_rate.rate - compute_employer_contribution_for_spouse(benefit_detail, sps_benefit_rate.rate))
      ee_sps_rate
    else
      0
    end
  end

  def self.compute_employee_dependent_rate(employee_id, benefit_detail)
    effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
    employee = Employee.find(employee_id)
    dependents_by_age = Dependent.where(employee_id: employee.id, relationship: "dependent")
    dependents = dependents_by_age.select{|d| effective_age(effective_date, d.date_of_birth, benefit_detail.id) < 26 }
    dependents.sort_by{|dep| [dep.date_of_birth]}.reverse
    oldest_dependent = dependents.first
    if employee.benefit_eligible == true
      ee_dob = employee.date_of_birth
      dep_dob = oldest_dependent.date_of_birth
      ee_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      dep_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, dep_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      ee_dep_rate = (ee_benefit_rate.rate - compute_employer_contribution_for_employee(benefit_detail, ee_benefit_rate.rate)) + (dep_benefit_rate.rate - compute_employer_contribution_for_dependent(benefit_detail, dep_benefit_rate.rate))
      ee_dep_rate
    else
      0
    end
  end

  def self.compute_employee_spouse_plus_one_rate(employee_id, benefit_detail)
    effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
    employee = Employee.find(employee_id)
    spouse = Dependent.find_by(employee_id: employee.id, relationship: "spouse")
    dependents_by_age = Dependent.where(employee_id: employee.id, relationship: "dependent")
    dependents = dependents_by_age.select{|d| effective_age(effective_date, d.date_of_birth, benefit_detail.id) < 26 }
    dependents.sort_by{|dep| [dep.date_of_birth]}.reverse
    oldest_dependent = dependents.first
    if employee.benefit_eligible == true
      ee_dob = employee.date_of_birth
      spouse_dob = spouse.date_of_birth
      dep_dob = oldest_dependent.date_of_birth
      ee_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      sps_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, spouse_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      dep_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, dep_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      total = ee_benefit_rate.rate + sps_benefit_rate.rate + dep_benefit_rate.rate
      ee_sps_plus_one_rate = total - compute_employer_contribution_for_spouse_plus_one(benefit_detail, total)
      ee_sps_plus_one_rate
    else
      0
    end
  end
  
  def self.compute_employee_dependent_plus_one_rate(employee_id, benefit_detail)
    effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
    employee = Employee.find(employee_id)
    dependents_by_age = Dependent.where(employee_id: employee.id, relationship: "dependent")
    dependents = dependents_by_age.select{|d| effective_age(effective_date, d.date_of_birth, benefit_detail.id) < 26 }
    dependents.sort_by{|dep| [dep.date_of_birth]}.reverse
    oldest_dependent = dependents.first
    second_dependent = dependents.second
    if employee.benefit_eligible == true
      ee_dob = employee.date_of_birth
      oldest_dep_dob = oldest_dependent.date_of_birth
      second_dep_dob = second_dependent.date_of_birth
      ee_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      oldest_dep_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, oldest_dep_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      second_dep_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, second_dep_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
      total = ee_benefit_rate.rate + oldest_dep_benefit_rate.rate + second_dep_benefit_rate.rate
      ee_dep_plus_one_rate = total - compute_employer_contribution_for_dependent_plus_one(benefit_detail, total)
      ee_dep_plus_one_rate
    else
      0
    end
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

  def self.compute_employer_contribution_for_spouse_plus_one(benefit_detail, benefit_rate)
    if benefit_detail.benefit_method == 'FIXED'
      benefit_detail.category_sps_pls_one
    else
      benefit_detail.category_sps_pls_one * benefit_rate  
    end
  end

  def self.compute_employer_contribution_for_dependent_plus_one(benefit_detail, benefit_rate)
    if benefit_detail.benefit_method == 'FIXED'
      benefit_detail.category_ch_pls_one
    else
      benefit_detail.category_ch_pls_one * benefit_rate  
    end
  end

  # AGE ON BENEFIT PROFILE EFFECTIVE DATE
  def self.effective_age(effective_date, dob, detail_id)
    # PUTS STATEMENTS FOR TERMINAL CHILLNESS
    puts "******AGE INFO******"
    puts "effective_date ====== #{effective_date}"
    puts "DOB of subject ====== #{dob}"
    # calculate current age of subject
    age = Date.today.year - dob.year
    age -= 1 if Date.today < dob + age.years
    puts "AGE of subject ====== #{age}"
    # calculate age of subject on effective date of Benefit Profile
    effective_age = effective_date.year - dob.year
    effective_age -= 1 if effective_date < dob + effective_age.years
    puts "EFFECTIVE_AGE of subject ====== #{effective_age}"
    # return age of subject on the effective date of the Benefit Profile (default to lowest age if age is lower)
    # ensure it sorts by age
    youngest_imported_age = BenefitRate.where(benefit_detail_id: detail_id).first
    puts "YOUNGEST_IMPORTED_AGE in this rate csv ====== #{youngest_imported_age.age}"
    puts "******AGE INFO******"
    if effective_age < youngest_imported_age.age
      effective_age = youngest_imported_age.age
      effective_age
    else
      effective_age
    end
  end
  
  # IMPORT RATE/AGE TABLE
  def self.import(benefit_detail_id, file_path)
    # file_path = '/home/ubuntu/workspace/core_revival/test/fixtures/BCBS_G712PFR.csv'
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
