class EmployeeBenefitSelectionTypesController < ApplicationController
	# NEEDS SECURITY METHODS FOR ROUTES
	before_filter :authenticate_user!
	before_filter :authorize_company!
	before_filter :authorize_manager_or_self!, only: [:manager_index]
	before_filter :check_for_birthday!, only: [:index]
	before_filter :check_for_benefit_eligibility!, only: [:index]
	before_filter :check_for_selection!, only: [:show]
	
	def index
		@company = Company.find(params[:company_id].to_i)
		employee = current_user.current_employee
		@current_employee_selections = EmployeeBenefitSelection.where(employee_id: employee.id)
		@benefit_types = BenefitProfile.where(company_id: @company.id).pluck(:benefit_type).uniq
	end

	# index all selections by type for manager to view EE roster
	def manager_index
		@company = Company.find(params[:company_id].to_i)
		@all_employees = @company.employees.order(:last_name)
		@employee_benefit_selections = EmployeeBenefitSelection.where(employee_id: @all_employees.ids, benefit_type: get_benefit_type_param).sort_by {|selection| [selection.employee.last_name]}
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: get_benefit_type_param).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
		@selection_categories = BenefitSelectionCategory.all
		#hmmm
	end

	def show
		@company = Company.find(params[:company_id].to_i) 
		@employee = current_user.current_employee
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: get_benefit_type_param).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
    @provider_plans = []
    @benefit_profiles.each {|plan| 
    	plan_name = plan.provider_plan.to_s
    	@provider_plans.push(plan_name)
    }
    puts "***"
    puts "#{params[:type]} PROFILE #{@benefit_profiles}"
    @rate_selection = get_benefit_rate_selection_model
    @rate_selection.build_choices! if @rate_selection.present?
    @selection_categories = BenefitSelectionCategory.all
    # variable for current salary and disability rate in Disability benefits display (move to other method?)
		@current_salary = Salary.where(employee_id: @employee.id).sort_by{|sal| [sal.start_date]}.reverse.first 
		if !@current_salary.nil?
	  	@current_disability_rate = @benefit_profiles.sort_by{|eff_date| [eff_date.effective_date]}.reverse.first.benefit_details.last.category_sub
	  elsif @current_salary.nil? && params[:type] == "Disability"
	  	flash[:message] = "Salary not found in Database: Disability coverage not yet available."
      redirect_to :back
    end
	end

	def accept
		puts "ACCEPTING BENEFIT ***********************************"
		@company = Company.find(params[:company_id].to_i) 
		@employee = current_user.current_employee
		@selection_categories = BenefitSelectionCategory.all
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: get_benefit_type_param).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
    @rate_selection = get_benefit_rate_selection_model_for_accept
    
    # Prompt User with custom flash before accepting benefits??
    if @rate_selection.valid? && @rate_selection.select_choice!
      flash[:info] = "Benefit Selection saved!"
      redirect_to company_employee_benefit_selection_types_path
    else
      flash[:error] = "Unable to save rate selection: #{@rate_selection.errors.full_messages.to_sentence}"
      # figure out how to get the form to reload with previous data here
      render :show
    end
	end

	def decline
		puts "DECLINE BENEFIT ***********************************"
		@company = Company.find(params[:company_id].to_i) 
		@employee = current_user.current_employee
		@benefit_profiles = BenefitProfile.where(company_id: @company.id, benefit_type: get_benefit_type_param).sort_by {|profile| [profile.benefit_profile_rank]}.reverse!
		# single out 1 BenefitProfile record, then single out 1 benefit detail (need to check nil)
		profile_to_decline = @benefit_profiles.first
		benefit_detail = BenefitDetail.find_by(benefit_profile_id: profile_to_decline.id, employee_category: @employee.employee_category)
		puts "BENEFIT DETAIL #{benefit_detail} ***********************************"
		EmployeeBenefitSelection.create!(employee: @employee,
                                      decline_benefit: true,
                                      benefit_detail_id: benefit_detail.id,
                                      benefit_type: get_benefit_type_param,
                                      benefit_selection_category_id: nil,
                                      amount: 0)
		redirect_to company_employee_benefit_selection_types_path
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
	    default_life_params = {
	    	employee: @employee,
	    	benefit_detail: BenefitDetail.find_by(benefit_profile_id: @benefit_profiles.first, employee_category: @employee.employee_category)
	    }
			if get_benefit_type_param == "Medical"
				@rate_selection = MedicalRateSelection.new(default_params)
			elsif get_benefit_type_param == "Dental"
				@rate_selection = DentalRateSelection.new(default_params)
			elsif get_benefit_type_param == "Disability"
				@rate_selection = DisabilityRateSelection.new(default_params)
			elsif get_benefit_type_param == "Life"
				@rate_selection = LifeRateSelection.new(default_life_params)
			else
				flash[:error] = "#{params[:type]} Rate selections not found"
				redirect_to company_employee_benefit_selection_types_path
				@rate_selection = nil
			end
		end

		def get_benefit_rate_selection_model_for_accept
			default_params = {
	      employee: @employee, 
	      benefit_details: BenefitDetail.where(benefit_profile_id: @benefit_profiles, employee_category: @employee.employee_category)
	    }
	    default_life_params = {
	    	employee: @employee,
	    	benefit_detail: BenefitDetail.find_by(benefit_profile_id: @benefit_profiles.first, employee_category: @employee.employee_category)
	    }
			if get_benefit_type_param == "Medical"
				medical_params = medical_rate_selection_params.merge(default_params)
				MedicalRateSelection.new(medical_params)
			elsif get_benefit_type_param == "Dental"
				dental_params = dental_rate_selection_params.merge(default_params)
				DentalRateSelection.new(dental_params)
			elsif get_benefit_type_param == "Disability"
				disability_params = disability_rate_selection_params.merge(default_params)
				DisabilityRateSelection.new(disability_params)
			elsif get_benefit_type_param == "Life"
				life_params = life_rate_selection_params.merge(default_life_params)
				LifeRateSelection.new(life_params)
			else
				@rate_selection = nil
				flash[:error] = "Rate selections not found"
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

   	def life_rate_selection_params
   		params.require(:life_rate_selection).permit(:employee_id,
   																					:company_id,
   																					:type,
   																					:employee_benefit_selection_type_type,
   																					choices_attributes: [:name, :label, :selected_amount, :monthly_rate, :employee_id, :benefit_detail_id,
   																					 :life_benefit_detail_id, :monthly_rates, :cap_amount, :base_coverage, :increment_amount])
   	end
   	# from EE controller - could make universal eventually
   	def authorize_manager_or_self!
      unless current_user.admin? || current_user.manager? || employee_is_current_user?
        redirect_to root_path
        flash[:error] = "You do not have permission to view page"
      end
    end
    # disallow use of benefits index for User/Employee with no birtday on record
    def check_for_birthday!
    	current_employee = current_user.current_employee
    	if current_employee.date_of_birth == nil
    		flash[:notice] = "Enter your date of birth to view Benefit options!"
    		redirect_to edit_company_employee_path(id: current_employee.id)
    	end
    end
    # disallow use of benefits index for User/Employee who is not benefit_eligible
		def check_for_benefit_eligibility!
			current_employee = current_user.current_employee
			if !current_employee.benefit_eligible? && current_user.manager?
				flash[:notice] = "Make Employee benefit-eligible to view Benefits"
    		redirect_to edit_company_employee_path(id: current_employee.id)
    	elsif !current_employee.benefit_eligible? && current_user.employee?
    		flash[:notice] = "Not currently listed as benefit-eligible"
    		redirect_to company_employee_path(id: current_employee.id)
    	end
		end
  	# If a user already has a selection, redirect them so they can't have more than one of the same type
  	def check_for_selection!
  		user_selections_by_type = EmployeeBenefitSelection.where(benefit_type: get_benefit_type_param, employee_id: current_user.employee_id)
  		if user_selections_by_type.count > 0
  			flash[:notice] = "#{get_benefit_type_param} selections already made for this user"
  			redirect_to company_employee_benefit_selection_types_path
  		else
  			# flash[:notice] = "#{get_benefit_type_param.to_s} selections NOT made yet"
  		end
  	end
end
