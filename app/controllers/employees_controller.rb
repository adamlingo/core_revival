class EmployeesController < ApplicationController
  # must be logged in
  before_filter :authenticate_user!
  before_filter :authorize_company!
  before_filter :authorize_manager!, except: [:show, :edit, :update]
  before_filter :authorize_manager_or_self!, only: [:show, :edit, :update]
  # call helper methods
  helper_method :sort_column, :sort_direction

  def index
    # only show Employees of selected company
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

  def invite
    @employee = set_employee_for_invite
    @company = find_company

    if @employee.user_id.nil?
      # do standard invitation
      user = User.invite!({:email => @employee.email})
      user.employee = true
      user.save!
      @employee.user_id = user.id
      @employee.save
      flash[:success] = "Initation sent to new User!"
    else
      # re-invite existing user
      user = User.find(@employee.user_id)
      user.invite!(current_user) # current_user sets invited_by attribute
      flash[:success] = "Employee re-invited!"
    end
    # reload EE index after Invite button click
    redirect_to company_employees_path
    
  end

  def create
    @employee = Employee.new(employee_params)
    @company = find_company
    @employee.company_id = @company.id
    if @employee.save
      flash[:success] = "New employee successfully created!"
      notify_zendesk('NEW EMPLOYEE ADDED')
      # current_user logs who sent the invite
      user = User.invite!({:email => @employee.email})
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
        # notify_zendesk('EMPLOYEE INFO Changed')
        # update User record email to match Employee
        user = User.find(@employee.user_id)
        # password reset invite
        # email notif here?
        user.email = @employee.email
        user.save!
      end
      # redirect to index for Managers, show for Employees, show for ER's own profile.
      if current_user.manager? && employee_is_current_user? || current_user.employee?
        redirect_to company_employee_path
      elsif current_user.manager? || current_user.admin?
        redirect_to company_employees_path
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

    def set_employee_for_invite
      find_company.employees.find(params[:employee_id].to_i)
    end

    def employee_params
      params.require(:employee).permit(:company_id, :first_name, :last_name, :email, 
        :address, :city, :state, :zip, :phone_number, :user_id, :sub_id, :date_of_birth,
        :date_of_hire, :encrypted_ssn, :ssn, :benefit_eligible, :view_salary)
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
      #Employee.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
      if Employee.column_names.include?(params[:sort])
        params[:sort]
      else
        "last_name"
      end
    end
    # direction for columns (default setting)
    def sort_direction
      #%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      if ['asc', 'desc'].include?(params[:direction])
        params[:direction]
      else
        "asc"
      end     
    end
    # return sorted
    def return_sorted
       @company.employees.order(sort_column + " " + sort_direction)      
    end
end
