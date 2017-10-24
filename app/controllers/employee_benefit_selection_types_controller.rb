class EmployeeBenefitSelectionTypesController < ApplicationController
	# NEEDS SECURITY METHODS FOR ROUTES
	before_filter :authenticate_user!
	before_filter :authorize_company!
	before_filter :authorize_manager_or_self! , only: [:manager_index]
	
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

	# index all selections by type for manager to view EE roster
	def manager_index
		@company = Company.find(params[:company_id].to_i)
		@all_employees = @company.employees 
		# if @all_employees.benefit_eligible?
    @employee_benefit_selections = EmployeeBenefitSelection.where(employee_id: @all_employees.ids, benefit_type: params[:type])
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: get_benefit_type_param).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
		@selection_categories = BenefitSelectionCategory.all
		#hmmm
	end

	def show
		@company = Company.find(params[:company_id].to_i) 
		@employee = current_user.current_employee
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: get_benefit_type_param).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
    @rate_selection = get_benefit_rate_selection_model
    @rate_selection.build_choices! if @rate_selection.present?
    @selection_categories = BenefitSelectionCategory.all
    # variable for current salary and disability rate in Disability benefits display
		@current_salary = Salary.where(employee_id: @employee.id).sort_by{|sal| [sal.start_date]}.reverse.first 
		if !@current_salary.nil?
	  	@current_disability_rate = @benefit_profiles.sort_by{|eff_date| [eff_date.effective_date]}.reverse.first.benefit_details.last.category_sub
	  elsif @current_salary.nil? && params[:type] == "Disability"
	  	flash[:message] = "Salary not found in Database: Disability coverage not yet available."
      redirect_to :back
    end

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
      flash[:info] = "Benefit Selection saved!"
      #redirect_to company_employee_benefit_selection_type_path(type: get_benefit_type_param)
      redirect_to company_employee_benefit_selection_types_path
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
				puts "************** MEDICAL PARAMS ***************"
				puts medical_params
				MedicalRateSelection.new(medical_params)
			elsif get_benefit_type_param == "Dental"
				dental_params = dental_rate_selection_params.merge(default_params)
				DentalRateSelection.new(dental_params)
			elsif get_benefit_type_param == "Disability"
				disability_params = disability_rate_selection_params.merge(default_params)
				DisabilityRateSelection.new(disability_params)
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
                                            choices_attributes: [:name, :plan_name, :label, :selected, :code, :amount, :benefit_detail_id] )
   	end

   	def dental_rate_selection_params
      params.require(:dental_rate_selection).permit(:employee_id,
                                            :company_id,
                                            :type,
                                            :employee_benefit_selection_type_type,
                                            choices_attributes: [:name, :plan_name, :label, :selected, :code, :amount, :benefit_detail_id] )
   	end

   	def disability_rate_selection_params
      params.require(:disability_rate_selection).permit(:employee_id,
                                            :company_id,
                                            :type,
                                            :employee_benefit_selection_type_type,
                                            choices_attributes: [:name, :plan_name, :label, :selected, :code, :amount, :benefit_detail_id] )
   	end
   	# from EE controller - could make universal eventually
   	def authorize_manager_or_self!
      unless current_user.admin? || current_user.manager? || employee_is_current_user?
        redirect_to root_path
        flash[:error] = "You do not have permission to view page"
      end
    end
end
