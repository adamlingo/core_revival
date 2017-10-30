class LifeRateSelection < ResourceModel::Base
	
	class RateChoice < ResourceModel::Base
    string_accessor :name # employee only, employee + spouse, etc...
    string_accessor :label
    string_accessor :selected_amount
    string_accessor :monthly_rate
    has_associated_model_collection :monthly_rates, class_name: 'MonthlyRate'
    attr_accessor :cap_amount
    attr_accessor :increment_amount
    def to_s
      "#{name} - #{code} - #{plan_name} - #{selected}"
    end

    def build_montly_rates
      monthly_rates = []
      # compute_rates 0 -> cap amount by increments
      monthly_rate = MonthlyRate.new(selected_amount: 10000, monthly_rate: 14.32)
      monthly_rates.push(monthly_rate)
    end
	end

  class MonthlyRate < ResourceModel::Base
    string_accessor :selected_amount
    string_accessor :monthly_rate
  end

	string_accessor :type
  string_accessor :employee_benefit_selection_type_type
	string_accessor :base_coverage
  integer_accessor :life_benefit_detail_id
  has_associated_model_collection :benefit_details, class_name: 'BenefitDetail'
	has_associated_resource_model_collection :choices, class_name: 'RateChoice'
	has_associated_model :employee

  #validate :ensure_one_and_only_one_choice_selected

	def init(attributes)
	  super(attributes)
	  # self.type = "Life"    
	end

  def build_choices!
  	self.choices = []
  	return unless self.employee.benefit_eligible
  	life_benefit_detail = get_life_benefit_detail
    life_benefit_detail_id = life_benefit_detail.id
  	self.base_coverage = life_benefit_detail.base_coverage
  	ee_attributes = {
  		name: "Employee",
  		label: "Employee",
  		cap_amount: life_benefit_detail.subscriber_cap,
  		increment_amount: life_benefit_detail.subscriber_increment
  	}
  	ee_rate_choice = RateChoice.new(ee_attributes)
    ee_rate_choice.build_montly_rates()
  	self.choices.push(ee_rate_choice)
  	spouse_attributes = {
  		name: "Spouse",
  		label: "Spouse",
  		cap_amount: life_benefit_detail.spouse_cap,
  		increment_amount: life_benefit_detail.spouse_increment
  	}
  	spouse_rate_choice = RateChoice.new(spouse_attributes)
  	self.choices.push(spouse_rate_choice)
    dependent_attributes = {
      name: "Dependent",
      label: "Dependent",
      cap_amount: life_benefit_detail.dependent_coverage,
      increment_amount: life_benefit_detail.dependent_coverage
    }
    dependent_rate_choice = RateChoice.new(dependent_attributes)
    self.choices.push(dependent_rate_choice)
  end

  def get_life_benefit_detail
    benefit_detail = benefit_details.first
    LifeBenefitDetail.find_by(benefit_detail_id: benefit_detail.id)
  end

  def to_choices_string
    puts "No choices" if self.choices.nil? || self.choices.length == 0
    str = []
    self.choices.each {|choice|
      str.push(choice.to_s)
    }
    str.join(', ')
  end

  # def self.compute_employee_rate(employee_id, employee_benefit_selection_id)
  #   ee_selection = EmployeeBenefitSelection.find(employee_benefit_selection_id)
  #   benefit_detail = BenefitDetail.find(ee_selection.benefit_detail_id)
  #   life_benefit_detail = LifeBenefitDetail.find(benefit_detail_id: benefit_detail.id)
  #   effective_date = BenefitProfile.find(benefit_detail.benefit_profile_id).effective_date
  #   employee = Employee.find(employee_id)
  #   if employee.benefit_eligible == true
  #     ee_dob = employee.date_of_birth
  #     ee_benefit_rate = BenefitRate.find_by(age: effective_age(effective_date, ee_dob, benefit_detail.id), benefit_detail_id: benefit_detail.id)
  #     ee_rate = ee_benefit_rate.rate - compute_employer_contribution_for_employee(benefit_detail, ee_benefit_rate.rate)
  #     ee_rate
  #   else
  #     0
  #   end
  # end 

end