class DisabilityBenefitRate < ActiveRecord::Base
  belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id
  
  # COMPUTE BENEFIT RATES
  def self.get_employee_rate(employee_id, benefit_detail)
    rate = benefit_detail.category_sub
    rate
  end
end