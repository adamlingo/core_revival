class DentalBenefitRate < ActiveRecord::Base
  belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id
  
  # COMPUTE BENEFIT RATES
  def self.compute_employee_rate(employee_id, benefit_detail)
  end  

  def self.compute_employee_spouse_rate(employee_id, benefit_detail)
  end

  # def self.compute_employee_dependent_rate(employee_id, benefit_detail)
  # end

  def self.compute_employee_spouse_plus_one_rate(employee_id, benefit_detail)
  end
  
  def self.compute_employee_dependent_plus_one_rate(employee_id, benefit_detail)
  end  

  # NO ER CONTRIBUTION FOR DENTAL (ALL FIXED RATES AS OF NOW, ELSE SEE MEDICAL)
  def self.compute_employer_contribution_for_employee(benefit_detail, benefit_rate)
    benefit_detail.category_sub
  end

  def self.compute_employer_contribution_for_spouse(benefit_detail, benefit_rate)
    benefit_detail.category_sps
  end

  def self.compute_employer_contribution_for_spouse_plus_one(benefit_detail, benefit_rate)
    benefit_detail.category_sps_pls_one
  end

  def self.compute_employer_contribution_for_dependent_plus_one(benefit_detail, benefit_rate)
    benefit_detail.category_ch_pls_one
  end
  # AGE ON BENEFIT PROFILE EFFECTIVE DATE (FIXED RATES NOT EFFECTED BY AGE OF SUBSCRIBERS)
  
  # NO IMPORT NEEDED FOR RATES YET, CURRENT DENTAL RATES FIXED