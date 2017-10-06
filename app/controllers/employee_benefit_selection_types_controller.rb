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
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: get_benefit_type_param).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
    @rate_selection = get_benefit_rate_selection_model
    choices = @rate_selection.build_choices! if @rate_selection.present?
    # dto sanitize or transform data
    @choices_dto = @rate_selection.rate_choices_dto(choices) if choices.present?
    @selection_categories = BenefitSelectionCategory.all

    puts "*********************************"
    puts @choices_dto
    puts "*********************************"
	end

	def accept
		puts "ACCEPTING BENEFIT ***********************************"
		@company = Company.find(params[:company_id].to_i) 
		@employee = current_user.current_employee
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: get_benefit_type_param).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
    @rate_selection = get_benefit_rate_selection_model

	end

	def get_benefit_type_param
		params[:type] || params[:employee_benefit_selection_type_type]
	end

	def get_benefit_rate_selection_model
		default_params = {
      employee: @employee, 
      benefit_details: BenefitDetail.where(benefit_profile_id: @benefit_profiles, employee_category: @employee.employee_category)
    }

		if get_benefit_type_param == "Medical"
			@rate_selection = MedicalRateSelection.new(default_params)
		else
			# future Life and Dental
			@rate_selection = nil
		end
	end
end
