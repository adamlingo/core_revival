class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  # must be logged in
  before_filter :authenticate_user!

  # edit index
  def index
    # only show all Employees of selected company
    @company = Company.find(params[:company_id])
    @employees = @company.employees
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def edit
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
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :company_id)
    end
end
