class BenefitDetail < ActiveRecord::Base
  belongs_to :benefit_profile
  has_one :benefit_rate
  
  validates_presence_of :benefit_profile_id
  
end
