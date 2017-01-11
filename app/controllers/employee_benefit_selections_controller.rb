class EmployeeBenefitSelectionsController < ApplicationController
  include EmployeeBenefitSelectionsHelper
  before_action :set_employee_benefit_selection, only: [:show, :edit, :update, :destroy]

  # GET /employee_benefit_selections
  # GET /employee_benefit_selections.json
  def index
    @employee_benefit_selections = EmployeeBenefitSelection.where(employee_id: params[:employee_id])
    @employee = Employee.find(params[:employee_id])
  end

  # GET /employee_benefit_selections/1
  # GET /employee_benefit_selections/1.json
  def show
  end

  # GET /employee_benefit_selections/new
  def new
    @employee_benefit_selection = EmployeeBenefitSelection.new(employee_id: params[:employee_id])
    @benefit_types = EmployeeBenefitDetailSelection.get_benefit_types(params[:company_id])
    @benefit_selections = EmployeeBenefitDetailSelection.get_choices(params[:company_id])
  end

  # GET /employee_benefit_selections/1/edit
  def edit
    @benefit_types = EmployeeBenefitDetailSelection.get_benefit_types(params[:company_id])
    @benefit_selections = EmployeeBenefitDetailSelection.get_choices(params[:company_id])
  end

  # POST /employee_benefit_selections
  # POST /employee_benefit_selections.json
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

  # PATCH/PUT /employee_benefit_selections/1
  # PATCH/PUT /employee_benefit_selections/1.json
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

  # DELETE /employee_benefit_selections/1
  # DELETE /employee_benefit_selections/1.json
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
