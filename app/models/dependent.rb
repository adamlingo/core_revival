class Dependent < ActiveRecord::Base
    belongs_to :employee
    validates_presence_of :employee_id
    
    
    def new
    end

end
