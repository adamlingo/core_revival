class CompanyFolder < ActiveRecord::Base
  belongs_to :companies
  belongs_to :folders
end
