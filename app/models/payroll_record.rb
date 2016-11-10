class PayrollRecord < ActiveRecord::Base
  belongs_to :companies
  has_one :employee
end
