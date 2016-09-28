class EmployeesController < ApplicationController
  # must be logged in
  # before_filter :authenticate_user!
  #before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    # only show all Employees of selected company
    @employees = find_company.employees
  end

  def show
    @employee = set_employee
  end

  def new
    @employee = Employee.new
    @company = find_company
    @employee.company_id = @company.id
  end

  def edit
    @employee = set_employee
  end

  def create
    @employee = Employee.new(employee_params)

    # @user = User.new(user_params) << want to use :email field for new user record
    # need @employee.save if/else clause to render proper template
    if @employee.save
      flash[:success] = "New employee created"
      # create User invite
      user = User.invite!(:email => @employee.email)
      user.employee = true
      user.save!
      @employee.user_id = user.id
      @employee.save
      redirect_to company_employees_path
    else
      render 'new'
    end
    
  end

  #def update
    
  #end

  def destroy
    # cannot delete records currently from client-side
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Employees need to find company they are associated with
    def find_company
      Company.find(params[:company_id])
    end

    def set_employee
      find_company.employees.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:company_id, :first_name, :last_name, :email)
    end
end
