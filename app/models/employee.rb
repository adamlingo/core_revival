class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :companies
end
