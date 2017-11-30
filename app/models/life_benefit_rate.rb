class LifeBenefitRate < ActiveRecord::Base
	belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id

	def self.lookup_employee_rate_per_thousand(employee_id, benefit_detail_id)
		employee = Employee.find(employee_id)
		ee_dob = employee.date_of_birth
		benefit_detail = BenefitDetail.find(benefit_detail_id)
		effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
		benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
		benefit_rate.rate
	end

	def self.lookup_spouse_rate_per_thousand(employee_id, benefit_detail_id)
		0.35
	end

	def self.lookup_dependent_rate(life_benefit_detail_id)
		0.45
	end

	# AGE ON BENEFIT PROFILE EFFECTIVE DATE
  def self.effective_age(effective_date, dob, detail_id)
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
    # return age of subject on the effective date of the Benefit Profile (default to lowest age if lower)
    # ensure it sorts by age
    youngest_imported_age = BenefitRate.where(benefit_detail_id: detail_id).first
    puts "*****************************"
    puts youngest_imported_age.age
    if effective_age < youngest_imported_age.age
      effective_age = youngest_imported_age.age
      effective_age
    else
      effective_age
    end
  end

end
