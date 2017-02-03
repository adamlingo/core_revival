class EmployeeBenefitSelectionsController < ApplicationController
  include EmployeeBenefitSelectionsHelper
  before_action :set_employee_benefit_selection, only: [:show, :edit, :update, :destroy]

  def index
    @employee_benefit_selections = EmployeeBenefitSelection.where(employee_id: params[:employee_id])
    @employee = Employee.find(params[:employee_id])
  end

  def show
    ben_detail_id = @employee_benefit_selection.benefit_detail_id.to_i
    ben_detail = BenefitDetail.find(ben_detail_id)
    @ben_profile = BenefitProfile.find(ben_detail.benefit_profile_id.to_i)
    @effective_date = @ben_profile.effective_date
    # @benefit_rate = BenefitRate.compute_rate(employee.id, ben_detail_id, @effective_date)
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
      params.require(:employee_benefit_selection).permit(:employee_id, :benefit_type, :decline_benefit, :benefit_detail_id)
    end
end
