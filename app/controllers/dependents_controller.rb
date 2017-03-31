class DependentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_company!
  # before_filter :authorize_my_company!
  # before_filter :authorize_manager!
  
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

    def authorize_my_company!
      check_company(params[:id])
    end

end
