class EmployeesController < ApplicationController
  # must be logged in
  before_filter :authenticate_user!
  before_filter :authorize_company!
  before_filter :authorize_manager!, except: [:show, :edit, :update]
  before_filter :authorize_manager_or_self!, only: [:show, :edit, :update]
  # call helper methods
  helper_method :sort_column, :sort_direction

  def index
    # only show all Employees of selected company
    @company = find_company
    @employees = return_sorted
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
      flash[:success] = "New employee successfully created!"

      notify_zendesk('NEW EMPLOYEE ADDED')
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

    def employee_params
      params.require(:employee).permit(:company_id, :first_name, :last_name,
         :email, :address, :city, :state, :zip, :phone_number, :user_id, :sub_id, :date_of_birth)
    end

    def authorize_manager_or_self!
      unless current_user.admin? || current_user.manager? || employee_is_current_user?
        redirect_to root_path
        flash[:error] = "You do not have permission to view page"
      end
    end

    # single out if EE is user when it's supposed to be manager
    def employee_is_current_user?
      current_user.employee_id == params[:id].to_i
    end

    # sort column method (default setting)
    def sort_column
      Employee.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
    end
    # direction for columns (default setting)
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    # return sorted
    def return_sorted
      @company.employees.order(sort_column + " " + sort_direction)
    end
end
