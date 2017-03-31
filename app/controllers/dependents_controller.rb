class DependentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_company!
  before_filter :authorize_ee_is_user!
  
  def index
	  @dependents = Dependent.where(employee_id: current_user.employee_id)
  end

  def show
    
  end

  def new
    @dependent = Dependent.new
  end

  def edit
    
  end

  def update
    
  end

  private
    def set_dependent
      @dependent = Dependent.find(params[:id])
    end

    def dependent_params
      params.require(:dependent).permit(:employee_id, :relationship, :date_of_birth, :first_name, :last_name)
    end

    # can only see your own dependents
    def authorize_ee_is_user!
      unless current_user.employee_id == params[:employee_id].to_i
      	redirect_to company_employee_dependents_path(employee_id: current_user.employee_id)
      	flash[:error] = "You only have permission to view your own dependents"
      end
    end

end
