class BenefitDetail < ActiveRecord::Base
  belongs_to :benefit_profile
  has_one :benefit_rate
end
