class Company < ActiveRecord::Base
  # attr_accessor :name
  # the above line blocks Admin save records for Co. name, look into

  # Company is parent of employees
  has_many :employees

  validates_presence_of :name
end
  