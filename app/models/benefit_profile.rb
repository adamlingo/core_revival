class BenefitProfile < ActiveRecord::Base
  belongs_to :company
  has_many :employees, through: :company
  has_many :benefit_details
  
  validates_presence_of :company_id
  
end
