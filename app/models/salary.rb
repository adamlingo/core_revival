class Salary < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :start_date
    validates_presence_of :rate
    validates_presence_of :pay_type
    


end
