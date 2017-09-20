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
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: params[:type]).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
    @rate_selection = get_benefit_rate_selection_model
    @choices = @rate_selection.build_choices! if @rate_selection.present?
    puts "*********************************"
    puts @choices
    puts "*********************************"
	end

	def get_benefit_rate_selection_model
		default_params = {
      employee: @employee, 
      benefit_details: BenefitDetail.where(benefit_profile_id: @benefit_profiles, employee_category: @employee.employee_category)
    }

		if params[:type] == "Medical"
			@rate_selection = MedicalRateSelection.new(default_params)
		else
			# future Life and Dental
			@rate_selection = nil
		end
	end
end
