class EmployeeFolder < ActiveRecord::Base
  belongs_to :employees
  belongs_to :folders
end
