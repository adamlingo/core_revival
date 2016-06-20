class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  has_many :benefit_details
  has_many :benefit_profiles, through: :benefit_details
end
