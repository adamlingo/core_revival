class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  has_many :benefit_profiles, through: :company
end
