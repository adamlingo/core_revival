class SalariesController < ApplicationController
    
    before_filter :authenticate_user!
    before_filter :authorize_manager!
    
    
    def index
        @employee = set_employee
        @company = find_company
        @salaries = Salary.all
    end

    def show
        @employee = set_employee
        @company = find_company
    end
    
    def edit
        @employee = set_employee
        @company = find_company
    end
    
    def new
        @employee = set_employee
        @company = find_company
        @salary = Salary.new
    end
    
    def create
      @employee = Employee.find(params[:employee_id])
      @company = find_company
      @current_start_date = Salary.find(params[:employee_id, @employee.employee_id, :start_date.last])
      @salary = Salary.new(salary_params)
      if @current_start_date <= @salary.start_date
        @salary.employee_id = @employee.id
        if @salary.save
          flash[:success] = "New payrate updated"
          redirect_to company_employees_path
        else
          render 'new'
        end
      else
        flash[:error] = "Start Date must be after Current Pay Start Date"
      end
    end
    
    
      private
   
    
        # Employees need to find company they are associated with
        def find_company
          Company.find(params[:company_id].to_i)
        end
    
        def set_employee
          Employee.find(params[:employee_id])
        end
    
        # Never trust parameters from the scary internet, only allow the white list through.
        def salary_params
          params.require(:salary).permit(:employee_id, :start_date, :rate, :end_date, :pay_type)
        end
    
    
end
