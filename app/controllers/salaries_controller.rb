class SalariesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_manager!
  
  def index
    @employee = set_employee
    @company = find_company
    @salaries = Salary.where(employee_id: @employee.id)
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
    
    if @employee.current_salary.present?
      @current_start_date = @employee.current_salary.start_date
    else
      @current_start_date = nil
    end
      
    @salary = Salary.new(salary_params)
    @salary.employee_id = @employee.id
    
    if @current_start_date.nil?
      if @salary.save
        flash[:success] = "New payrate updated"
        redirect_to company_employees_path
      else
        flash[:error] = "Save new Pay Rate failed"
        render 'new'
      end
    elsif @current_start_date <= @salary.start_date
      @employee.current_salary.end_date = @salary.start_date
      if @salary.save && @employee.current_salary.save!
        flash[:success] = "New Payrate Updated"
        redirect_to company_employees_path
      else
        flash[:error] = "Save new Pay Rate failed"
        render 'new'
      end
    else
      flash[:error] = "Start Date must be after Current Pay Start Date"
      render 'new'
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
