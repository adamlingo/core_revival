class Employee < ActiveRecord::Base
  attr_accessible :name, :company_id
  belongs_to :companies
end
