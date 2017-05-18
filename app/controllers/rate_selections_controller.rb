class RateSelectionsController < ApplicationController

  def new
    @rate_selection = RateSelection.new
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @company = Company.find(@employee.company_id)
    accept_params = rate_selection_params
    @rate_selection = RateSelection.new(accept_params)

    if @rate_selection.valid? && @rate_selection.select_choice!
      flash[:info] = "Benefit selection saved!"
      redirect_to company_employee_employee_benefit_selections_path
    else
      flash[:error] = "Unable to save rate selection. #{@rate_selection.errors.full_messages.to_sentence}"
      render :new
    end
  end

  private

    def rate_selection_params
      params.require(:rate_selection).permit(:employee_id, 
                                            :employee_benefit_selection_id,
                                            :company_id, 
                                            choices_attributes: [:name, :label, :selected, :code, :amount] )
    end
end
