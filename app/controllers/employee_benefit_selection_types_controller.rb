class EmployeeBenefitSelectionTypesController < ApplicationController
	
	def index
		@company = Company.find(params[:company_id].to_i)
		employee = current_user.current_employee
		if employee.benefit_eligible
			@benefit_types = BenefitProfile.where(company_id: @company.id).pluck(:benefit_type).uniq
		else
			redirect_to '/home'
			flash[:message] = "Not eligible for benefits."
		end
	end

	def show
		@company = Company.find(params[:company_id].to_i) 
		@employee = current_user.current_employee
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: params[:type])
    #benefit_detail = BenefitDetail.find(benefit_selection.benefit_detail_id)
	end
end
