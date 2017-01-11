class Salary < ActiveRecord::Base
    belongs_to :employee
    
    validates_presence_of :start_date
    validates_presence_of :rate
    validates_presence_of :pay_type
    
    # def start_date
    #     self.start_date
    # end
    
    # def rate
    #     self.rate
    # end
    
    # def pay_type
    #     self.pay_type
    # end
    
    # def employee_id
    #   self.employee_id
    # end
    
    # def end_date
    #     self.end_date
    # end
    
    # def pay_type
    #     self.pay_type
    # end
    
    


end
