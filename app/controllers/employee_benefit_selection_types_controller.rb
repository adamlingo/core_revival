class EmployeeBenefitSelectionTypesController < ApplicationController
	# NEEDS SECURITY METHODS FOR ROUTES
	before_filter :authenticate_user!
	
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
    @rate_selection.build_choices! if @rate_selection.present?
    @selection_categories = BenefitSelectionCategory.all
    # variable for current salary in Disability benefits
    @current_salary = Salary.where(employee_id: @employee.id).sort_by{|sal| [sal.start_date]}.reverse.first

    # dto sanitize or transform data
    # @choices_dto = @rate_selection.rate_choices_dto(choices) if choices.present?
	end

	def accept
		puts "ACCEPTING BENEFIT ***********************************"
		@company = Company.find(params[:company_id].to_i) 
		@employee = current_user.current_employee
		@selection_categories = BenefitSelectionCategory.all
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: get_benefit_type_param).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
    @rate_selection = get_benefit_rate_selection_model_for_accept
    puts @rate_selection.to_choices_string
    if @rate_selection.valid? && @rate_selection.select_choice!
      flash[:info] = "Benefit selection saved!"
      redirect_to company_employee_benefit_selection_type_path(type: get_benefit_type_param)
    else
      flash[:error] = "Unable to save rate selection: #{@rate_selection.errors.full_messages.to_sentence}"
      # figure out how to get the form to reload with previous data here
      redirect_to :back
    end
	end

	private
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
			elsif get_benefit_type_param == "Dental"
				@rate_selection = DentalRateSelection.new(default_params)
			elsif get_benefit_type_param == "Disability"
				@rate_selection = DisabilityRateSelection.new(default_params)
			else
				# future Life
				@rate_selection = nil
			end
		end

		def get_benefit_rate_selection_model_for_accept
			default_params = {
	      employee: @employee, 
	      benefit_details: BenefitDetail.where(benefit_profile_id: @benefit_profiles, employee_category: @employee.employee_category)
	    }
			if get_benefit_type_param == "Medical"
				medical_params = medical_rate_selection_params.merge(default_params)
				MedicalRateSelection.new(medical_params)
			# elsif get_benefit_type_param == "Dental"
			# 	dental_params = dental_rate_selection_params.merge(default_params)
			# 	DentalRateSelection.new(dental_params)
			else
				# future Life
				@rate_selection = nil
			end
		end

		def medical_rate_selection_params
      params.require(:medical_rate_selection).permit(:employee_id,
                                            :company_id,
                                            :type,
                                            :employee_benefit_selection_type_type,
                                            :selected,
                                            choices_attributes: [:name, :plan_name, :label, :selected, :code, :amount] )
   	end
end
