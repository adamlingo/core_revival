class Employee < ActiveRecord::Base
  # child of Company
  belongs_to :company
end
