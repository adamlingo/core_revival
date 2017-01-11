class EmployeesController < ApplicationController
  # must be logged in
  before_filter :authenticate_user!
  before_filter :authorize_company!
  before_filter :authorize_manager!, except: [:show, :edit, :update]

  def index
    # only show all Employees of selected company
    @company = find_company
    @employees = @company.employees
  end

  def show
    @employee = set_employee
    @company = find_company
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
      flash[:success] = "New employee created!"

      notify_zendesk('NEW EMPLOYEE ADDED')

      # create User & User invite (skip invite for now)
      user = User.invite!(:email => @employee.email) do |u|
        u.skip_invitation = true
      end
      user.employee = true
      user.save!
      @employee.user_id = user.id
      @employee.save
  
      redirect_to company_employees_path, notice: 'Employee was successfully created.'
    else
      render 'new'
    end
    
  end

  def update
    @employee = set_employee
    
    if @employee.update_attributes(employee_params)
      flash[:success] = "Employee updated!"
      if @employee.user_id.present?
        
        notify_zendesk('EMPLOYEE INFO Changed')
  
        # update User record email to match Employee
        user = User.find(@employee.user_id)
        # password reset invite
        # email notif here?
        user.email = @employee.email
        user.save!
      end
      # redirect to index for Managers, show for Employees
      if current_user.manager? || current_user.admin?
        redirect_to company_employees_path
      else
        redirect_to company_employee_path
      end
    else
      render 'edit'
    end

  end

  def destroy
    # cannot delete records currently from client-side
  end

  private
    def notify_zendesk(message)
      # remove if block once we know how to "authenticate" in the tests.
      if current_user.present?
        # send zen desk notification of employee info changes
        user_hash = {name: @employee.last_name, email: @employee.email}
        ticket_id = ZendeskService.create_ticket(user_hash, "Information Edited by #{current_user.email}", message)
        puts "ticket id is: "
        puts ticket_id
      end
    end

    # Employees need to find company they are associated with
    def find_company
      Company.find(params[:company_id].to_i)
    end

    def set_employee
      find_company.employees.find(params[:id].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:company_id, :first_name, :last_name,
         :email, :address, :city, :state, :zip, :phone_number, :user_id, :sub_id)
    end
end
