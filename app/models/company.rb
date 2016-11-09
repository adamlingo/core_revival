class Company < ActiveRecord::Base
  # Company is parent of employees, ben. profiles
  has_many :employees
  has_many :payroll_records
  has_many :benefit_profiles
  has_many :company_folders
 
  validates_presence_of :name
end
  