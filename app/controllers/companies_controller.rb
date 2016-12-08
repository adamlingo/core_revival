class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  # before_filter :authorize_company! <-- private method instead here
  before_filter :authorize_my_company!
  before_filter :authorize_manager!
  
  def index
    if current_user.admin?
      @companies = Company.all
    else
      @companies = Company.where(id: current_user.company_id)
    end
  end

  def show
    @company = Company.find(params[:id])
    @employees = @company.employees
    @benefits = @company.benefit_profiles
    # @details = @employees.benefit_detail
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    # kill auto-generated code for create, test code first
    if @company.save
      flash[:success] = "New company saved"
      redirect_to @company
    else
      render 'new'
    end
  end

  # def update
    
  # end

  def destroy
    #Company.find(params[:id].destroy
     # flash[:success] = 'Company deleted' 
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :email, :address, :city, :state,:zip,
                                      :phone_number, :federal_id_number, :state_wh_number,
                                      :unemployment_number, :processor_name, :pay_frequency,
                                      :timework_id, :timework_pass)
    end

    def authorize_my_company!
      unless current_user.admin?
        company_id = params[:id]
        if company_id.present? && (current_user.company_id != company_id.to_i)
          redirect_to root_path
          flash[:error] = "You do not have permission to view page"
        end
      end
    end
end
