class Company < ActiveRecord::Base
  # Company is parent of employees
  has_many :employees
end
