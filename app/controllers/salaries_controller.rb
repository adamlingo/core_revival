class SalariesController < ApplicationController
    
    before_filter :authenticate_user!
    before_filter :authorize_manager!
    
    
    def index
        @employees = find_company.employees
        @employee = Employee.find(params[:employee_id])
        @company = find_company
        
        @salaries = Salary.all
    end

    def show
        @employee = set_employee
        @company = find_company
    end
    
    def edit
        @employees = set_employee
        @company = find_company
    end
    
    def new
      @employee = Employee.find(params[:employee_id])
      @company = find_company
      @salary = Salary.new
      if @salary.save
        flash[:success] = "New payrate updated"
        # notify_zendesk('Employee payrate updated')
        redirect_to company_employees_path
      else
        render 'new'
      end
    end
    
    
      private
        # def notify_zendesk(message)
        #   # remove if block once we know how to "authenticate" in the tests.
        #   if current_user.present?
        #     # send zen desk notification of employee info changes
        #     user_hash = {name: @employee.last_name, email: @employee.email}
        #     ticket_id = ZendeskService.create_ticket(user_hash, "Information Edited by #{current_user.email} for employee #{@employee.last_name}, #{@employee.first_name} in company #{@employee.company_id}", message)
        #     puts "ticket id is: "
        #     puts ticket_id
        #   end
        # end
    
        # Employees need to find company they are associated with
        def find_company
          Company.find(params[:company_id].to_i)
        end
    
        def set_employee
          find_company.employees.find(params[:id].to_i)
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def employee_params
          params.require(:employee).permit(:company_id, :first_name, :last_name, :email, :user_id)
        end
    
    
end
