class BenefitProfile < ActiveRecord::Base
  belongs_to :company
  has_many :benefit_details
  has_many :employees, through: :company
end
