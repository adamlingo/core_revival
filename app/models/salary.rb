class Salary < ActiveRecord::Base
    belongs_to :employee
    
    def employee
        @employee = Employee.find(params[:employee_id])
    end
    
    def company
    end

end
