class DisabilityRateSelection < ResourceModel::Base

  class RateChoice < ResourceModel::Base
    string_accessor :name # employee only, employee + spouse, etc...
    string_accessor :label
    string_accessor :code
    string_accessor :plan_name
    boolean_accessor :selected # is the checkbox is checked?
    attr_accessor :amount
    def to_s
      "#{name} - #{code} - #{plan_name} - #{selected}"
    end
  end

  string_accessor :type
  has_associated_model :employee
  has_associated_model_collection :benefit_details, class_name: 'BenefitDetail'
  has_associated_resource_model_collection :choices, class_name: 'RateChoice'

  validate :ensure_one_and_only_one_choice_selected

  def init(attributes)
    super(attributes)
    # self.type = "Disability"
  end

  def build_choices!
    self.benefit_details.each {|benefit_detail|
      benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB")
      rate = DisabilityBenefitRate.get_employee_rate(self.employee.id, benefit_detail)
      self.choices.push(RateChoice.new(plan_name: benefit_detail.benefit_profile.provider_plan, name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))      
    }
    self.choices
  end

  def to_choices_string
    puts "No choices" if self.choices.nil? || self.choices.length == 0
    str = []
    self.choices.each {|choice|
      str.push(choice.to_s)
    }
    str.join(', ')
  end

  def select_choice!
    return false unless self.valid?

    selected_rate = choices.select{|choice| choice.selected }.first
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts selected_rate
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^"
    # # CREATE EMPLOYEE BENEFIT SELECTION RECORD TO SAVE AMOUNT TO
    # self.employee_benefit_selection.amount = selected_rate.amount
    # benefit_selection_category = BenefitSelectionCategory.find_by(code: selected_rate.code)
    # self.employee_benefit_selection.benefit_selection_category_id = benefit_selection_category.id
    # self.employee_benefit_selection.save!
    selected_rate.present?
  end

  private
  	def ensure_one_and_only_one_choice_selected
  	  return unless self.choices.present?

  	  employee_choices = self.choices.select {|choice| choice if choice.selected }
  	  if employee_choices.count > 1
  	  	self.errors.add(:base, 'Only ONE rate can be selected.')
  	  end

  	  if employee_choices.count < 1
  	  	self.errors.add(:base, 'Must select a rate before submitting.')
  	  end
  	end
end