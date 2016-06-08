class CompaniesController < ApplicationController
  # muted restrictions
  # before_action :set_company, only: [:show, :edit, :update, :destroy]
 
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
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
    # kill auto-generated code for update
  # end

  def destroy
    Company.find(params[:id].destroy
      flash[:success] = "Company deleted"  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name)
    end
end
