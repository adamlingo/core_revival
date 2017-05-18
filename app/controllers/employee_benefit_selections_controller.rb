class EmployeeBenefitSelectionsController < ApplicationController
  include EmployeeBenefitSelectionsHelper
  before_action :set_employee_benefit_selection, only: [:show, :edit, :update, :destroy]

  def index
    @employee = Employee.find(params[:employee_id])
    if @employee.benefit_eligible
      @employee_benefit_selections = EmployeeBenefitSelection.where(employee_id: params[:employee_id])
    else
      @employee_benefit_selections = []
    end

    @dependents = Dependent.where(employee_id: @employee.id)
  end

  def show
    @employee = Employee.find(params[:employee_id])
    @company = Company.find(@employee.company_id)
    @id = params[:id]

    default_params = {
      employee_id: params[:employee_id],
      employee_benefit_selection: EmployeeBenefitSelection.find(params[:id].to_i)
    }
    @rate_selection = RateSelection.new(default_params)
    @rate_selection.build_choices!

  end

  def new
    @employee_benefit_selection = EmployeeBenefitSelection.new(employee_id: params[:employee_id])
    @benefit_types = EmployeeBenefitDetailSelection.get_benefit_types(params[:company_id])
    @benefit_selections = EmployeeBenefitDetailSelection.get_choices(params[:company_id])
  end

  def edit
    @benefit_types = EmployeeBenefitDetailSelection.get_benefit_types(params[:company_id])
    @benefit_selections = EmployeeBenefitDetailSelection.get_choices(params[:company_id])
  end

  def create
    @employee_benefit_selection = EmployeeBenefitSelection.new(employee_benefit_selection_params)

    puts "*******************************************************"
    puts employee_benefit_selection_params
    puts @employee_benefit_selection

    respond_to do |format|
      if @employee_benefit_selection.save
        format.html { redirect_to company_employee_employee_benefit_selections_path, notice: 'Employee benefit selection was successfully created.' }
        format.json { render :show, status: :created, location: @employee_benefit_selection }
      else
        format.html { render :new }
        format.json { render json: @employee_benefit_selection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee_benefit_selection.update(employee_benefit_selection_params)
        format.html { redirect_to company_employee_employee_benefit_selections_path, notice: 'Employee benefit selection was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_benefit_selection }
      else
        @benefit_types = EmployeeBenefitDetailSelection.get_benefit_types(params[:company_id])
        @benefit_selections = EmployeeBenefitDetailSelection.get_choices(params[:company_id])
        format.html { render :edit }
        format.json { render json: @employee_benefit_selection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee_benefit_selection.destroy
    respond_to do |format|
      format.html { redirect_to company_employee_employee_benefit_selections_path, notice: 'Employee benefit selection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_benefit_selection
      @employee_benefit_selection = EmployeeBenefitSelection.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_benefit_selection_params
      params.require(:employee_benefit_selection).permit(:employee_id, :benefit_type, 
                                                          :decline_benefit, :benefit_detail_id, 
                                                          :benefit_selection_category_id)
    end
end