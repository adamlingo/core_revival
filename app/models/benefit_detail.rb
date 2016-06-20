class BenefitDetail < ActiveRecord::Base
  belongs_to :benefit_profile
  belongs_to :employee
end
