class DentalBenefitRate < ActiveRecord::Base
  belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id
  
  # COMPUTE BENEFIT RATES (DENTAL)
  def self.compute_employee_rate(employee_id, benefit_detail)
    rate = benefit_detail.category_sub
    rate
  end  

  def self.compute_employee_spouse_rate(employee_id, benefit_detail)
    rate = benefit_detail.category_sps
    rate
  end

  # def self.compute_employee_dependent_rate(employee_id, benefit_detail)
  # RATE NOT CURRENTLY IN USE FOR DENTAL - ONLY EMPLOYEE PLUS ALL CHILDREN, MINUS SPOUSE (dep_plus_one_rate)
  # end

  def self.compute_employee_spouse_plus_one_rate(employee_id, benefit_detail)
    rate = benefit_detail.category_sps_pls_one
    rate
  end
  
  def self.compute_employee_dependent_plus_one_rate(employee_id, benefit_detail)
    rate = benefit_detail.category_ch_pls_one
    rate
  end  

  # NO ER CONTRIBUTION FOR DENTAL (ALL FIXED RATES AS OF NOW, ELSE SEE MEDICAL)

  # AGE ON BENEFIT PROFILE EFFECTIVE DATE (FIXED RATES NOT EFFECTED BY AGE OF SUBSCRIBERS)
  
  # NO IMPORT NEEDED FOR RATES YET, CURRENT DENTAL RATES FIXED
end