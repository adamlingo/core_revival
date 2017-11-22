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
    attr_accessor :cap_amount
    attr_accessor :base_coverage
    attr_accessor :increment_amount

    def build_monthly_rates
      @monthly_rates = []
      # rate_per_thousand = lookup_rate_per_thousand
      # age_cap_percentage = lookup_age_cap_percentage
      # compute_rates base_amount, or 0 for no-coverage -> cap amount by increments
      # while !cap_amount
      monthly_rate = MonthlyRate.new(selected_amount: 10000, monthly_rate: 14.32)
      puts "^^^^^^^^^^^^^^ #{@monthly_rate}"
      @monthly_rates.push(monthly_rate)
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
  		benefit_detail_id: life_benefit_detail.benefit_detail_id,
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
  		benefit_detail_id: life_benefit_detail.benefit_detail_id,
      cap_amount: life_benefit_detail.spouse_cap,
  		increment_amount: life_benefit_detail.spouse_increment
  	}
  	spouse_rate_choice = RateChoice.new(spouse_attributes)
    spouse_rate_choice.build_monthly_rates()
  	self.spouse_choices = spouse_rate_choice


    dependent_attributes = {
      name: "Dependent",
      label: "Dependent",
      life_benefit_detail_id: life_benefit_detail.id,
      benefit_detail_id: life_benefit_detail.benefit_detail_id,
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

  def to_choices_string
    puts "No choices" if self.choices.nil? || self.choices.length == 0
    str = []
    self.choices.each {|choice|
      str.push(choice.to_s)
    }
    str.join(', ')
  end
end