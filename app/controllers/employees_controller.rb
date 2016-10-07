class EmployeesController < ApplicationController
  # must be logged in
  # before_filter :authenticate_user!
  #before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    # only show all Employees of selected company
    @company = find_company
    @employees = @company.employees
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
    @company = find_company
  end

  def create
    @employee = Employee.new(employee_params)
    @company = find_company
    @employee.company_id = @company.id
    # @user = User.new(user_params) << want to use :email field for new user record
    # need @employee.save if/else clause to render proper template
    if @employee.save
      flash[:success] = "New employee created"
      # create User invite
      # user = User.invite!(:email => @employee.email)
      # user.employee = true
      # user.save!
      # @employee.user_id = user.id
      # @employee.save
      redirect_to company_employees_path
    else
      render 'new'
    end
    
  end

  def update
    @employee = set_employee

    if @employee.update!(employee_params)
      redirect_to company_employees_path
    else
      redirect_to edit_company_employee_path(find_company, @employee) 
    end
  end

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
      Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      puts "IN employee_params: "
      puts params
      params.require(:employee).permit(:company_id, :first_name, :last_name, :email)
    end
end
