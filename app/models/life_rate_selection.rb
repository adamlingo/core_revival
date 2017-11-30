class LifeRateSelection < ResourceModel::Base
	
	class RateChoice < ResourceModel::Base
    string_accessor :name # employee only, employee + spouse, etc...
    string_accessor :label
    string_accessor :selected_amount
    # has_associated_model :monthly_rate
    integer_accessor :employee_id
    integer_accessor :benefit_detail_id
    integer_accessor :life_benefit_detail_id
    has_associated_model_collection :monthly_rates, class_name: 'MonthlyRate'
    integer_accessor :cap_amount
    integer_accessor :base_coverage
    integer_accessor :increment_amount

    def build_monthly_rates
      @monthly_rates = []
      rate_per_thousand = lookup_rate_per_thousand
      # age_cap_percentage = lookup_age_cap_percentage
      (base_coverage..cap_amount).step(increment_amount) do |amount|
        monthly_premium = (amount / 1000.00) * rate_per_thousand
        monthly_rate = MonthlyRate.new(selected_amount: amount, monthly_rate: monthly_premium)
        @monthly_rates.push(monthly_rate)
      end
      
    end

    def lookup_rate_per_thousand
      if self.name == "Employee"
        LifeBenefitRate.lookup_employee_rate_per_thousand(employee_id, benefit_detail_id)
      elsif self.name == "Spouse"
        LifeBenefitRate.lookup_spouse_rate_per_thousand(employee_id, benefit_detail_id)
      elsif self.name == "Dependent"
        LifeBenefitRate.lookup_dependent_rate(life_benefit_detail_id)
      else
        # flash error, validate
      end
    end

    def lookup_age_cap_percentage

    end
	end

  class MonthlyRate < ResourceModel::Base
    string_accessor :selected_amount
    string_accessor :monthly_rate
  end

	string_accessor :type
  string_accessor :employee_benefit_selection_type_type
	string_accessor :base_coverage
  has_associated_model :life_benefit_detail, class_name: 'LifeBenefitDetail'
	has_associated_resource_model :employee_choices, class_name: 'RateChoice'
  has_associated_resource_model :spouse_choices, class_name: 'RateChoice'
  has_associated_resource_model :dependent_choices, class_name: 'RateChoice'
	has_associated_model :employee
  has_associated_model :benefit_detail

  #validate :ensure_one_and_only_one_choice_selected

	def init(attributes)
	  super(attributes)
	  # self.type = "Life"    
	end

  def select_choice!
    return false unless self.valid?
    # up to 3 choices
    employee_selected_rates = employee_choices
    spouse_selected_rates = spouse_choices
    dependent_selected_rate = dependent_choices
    # binding.pry
    false
    # CREATE EMPLOYEE BENEFIT SELECTION RECORD TO SAVE AMOUNT TO
    # self.employee_benefit_selection.save!
    # if selected_rate.present?
    #   benefit_selection_category = BenefitSelectionCategory.find_by(code: selected_rate.code)
    #   EmployeeBenefitSelection.create!(employee: employee, 
    #                                   decline_benefit: false, 
    #                                   benefit_detail_id: selected_rate.benefit_detail_id,
    #                                   benefit_type: "Medical",
    #                                   benefit_selection_category_id: benefit_selection_category.id,
    #                                   amount: selected_rate.amount)
    # else
    #   false
    # end
  end

  def build_choices!
    # method too long currently!! - CodeClimate
  	return unless self.employee.benefit_eligible
  	life_benefit_detail = get_life_benefit_detail
    # useless assignment to variable?
    life_benefit_detail_id = life_benefit_detail.id
  	self.base_coverage = life_benefit_detail.base_coverage
  	
    ee_attributes = {
  		name: "Employee",
  		label: "Employee",
      employee_id: employee.id,
  		benefit_detail_id: life_benefit_detail.benefit_detail_id,
      base_coverage: life_benefit_detail.base_coverage,
      cap_amount: life_benefit_detail.subscriber_cap,
  		increment_amount: life_benefit_detail.subscriber_increment
  	}
  	ee_rate_choice = RateChoice.new(ee_attributes)
    ee_rate_choice.build_monthly_rates()
  	self.employee_choices = ee_rate_choice
    puts "************** Employee CHOICES #{self.employee_choices} *******"

  	spouse_attributes = {
  		name: "Spouse",
  		label: "Spouse",
      employee_id: employee.id,
  		benefit_detail_id: life_benefit_detail.benefit_detail_id,
      base_coverage: life_benefit_detail.spouse_increment,
      cap_amount: life_benefit_detail.spouse_cap,
  		increment_amount: life_benefit_detail.spouse_increment
  	}
  	spouse_rate_choice = RateChoice.new(spouse_attributes)
    spouse_rate_choice.build_monthly_rates()
  	self.spouse_choices = spouse_rate_choice

    dependent_attributes = {
      name: "Dependent",
      label: "Dependent",
      employee_id: employee.id,
      life_benefit_detail_id: life_benefit_detail.id,
      benefit_detail_id: life_benefit_detail.benefit_detail_id,
      base_coverage: life_benefit_detail.base_coverage,
      cap_amount: life_benefit_detail.dependent_coverage,
      increment_amount: life_benefit_detail.dependent_coverage
    }
    dependent_rate_choice = RateChoice.new(dependent_attributes)
    dependent_rate_choice.build_monthly_rates()
    self.dependent_choices = dependent_rate_choice
  end

  def get_life_benefit_detail
    # benefit_detail = benefit_details.first
    life_benefit_detail = LifeBenefitDetail.find_by(benefit_detail_id: benefit_detail.id)
    life_benefit_detail
  end

end