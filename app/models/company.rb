class Company < ActiveRecord::Base
  # Company is parent of employees, ben. profiles
  has_many :employees
  has_many :benefit_profiles
 
  validates_presence_of :name
end
  