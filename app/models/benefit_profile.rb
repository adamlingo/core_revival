class BenefitProfile < ActiveRecord::Base
  belongs_to :company
  has_many :benefit_details
end
