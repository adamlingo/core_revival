class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
  # each EE has a UserID
  belongs_to :user
  has_many :benefit_profiles, through: :company
end
