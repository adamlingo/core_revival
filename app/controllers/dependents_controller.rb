class DependentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_company!
  before_filter :authorize_ee_is_user!
  
  def index
	  @dependents = Dependent.where(employee_id: current_user.employee_id)
  end

  def show
    @dependent = set_dependent
  end

  def new
    @dependent = Dependent.new
    @employee = find_employee
    @company = find_company
  end

  def create
  	@dependent = Dependent.new(dependent_params)
  	@employee = find_employee
    @dependent.employee_id = @employee.id
  	if @dependent.save
  		flash[:success] = "Dependent created"
      redirect_to company_employee_dependents_path
  	else
  		render 'new'
  	end
  end

  def edit
    @dependent = set_dependent
  end  

  def update
    @dependent = set_dependent
    if @dependent.update_attributes(dependent_params)
    	flash[:success] = "Dependent updated!"
      redirect_to company_employee_dependents_path
    else
    	render 'edit'
    end
  end

  private
    def find_company
      Company.find(params[:company_id].to_i)
    end

  	def find_employee
  		Employee.find(params[:employee_id].to_i)
  	end

    def set_dependent
      find_employee.dependents.find(params[:id].to_i)
    end

    def dependent_params
      params.require(:dependent).permit(:relationship, :date_of_birth, :first_name, :last_name)
    end

    # can only see your own dependents
    def authorize_ee_is_user!
      unless current_user.employee_id == params[:employee_id].to_i
      	redirect_to company_employee_dependents_path(employee_id: current_user.employee_id)
      	flash[:error] = "You only have permission to view your own dependents"
      end
    end

end
