class MedicalRateSelection < ResourceModel::Base

  class RateChoice < ResourceModel::Base
    string_accessor :name # employee only, employee + spouse, etc...
    string_accessor :label
    string_accessor :code 
    boolean_accessor :selected # is the checkbox is checked?
    attr_accessor :amount
  end

  string_accessor :type
  has_associated_model :employee
  has_associated_model_collection :benefit_details, class_name: 'BenefitDetail'
  has_associated_resource_model_collection :choices, class_name: 'RateChoice'

  validate :ensure_one_and_only_one_choice_selected

  def init(attributes)
    super(attributes)
    self.type = "Medical"
  end

  def build_choices!
  	self.choices = []
  	return unless self.employee.benefit_eligible
    #return ["My Choices"]
  	dependents = Dependent.where(employee_id: self.employee.id, relationship: "dependent")
    spouse = Dependent.where(employee_id: self.employee.id, relationship: "spouse").first
    num_dependents = dependents.count
    plan_choices_hash = Hash.new

    self.benefit_details.each {|benefit_detail| 
      plan_choices = []

      benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB")
      rate = MedicalBenefitRate.compute_employee_rate(self.employee.id, benefit_detail)
      plan_choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
      if spouse.present?
        rate = MedicalBenefitRate.compute_employee_spouse_rate(self.employee.id, benefit_detail)
        benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-SPS")
        plan_choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
        if num_dependents > 0
          rate = MedicalBenefitRate.compute_employee_spouse_plus_one_rate(self.employee.id, benefit_detail)
          benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-SPS-PLUS-ONE")
          plan_choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
        end
      end

      if num_dependents >= 1
        rate = MedicalBenefitRate.compute_employee_dependent_rate(self.employee.id, benefit_detail)
        benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-DEP")
        plan_choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
      end

      if num_dependents >= 2 
        rate = MedicalBenefitRate.compute_employee_dependent_plus_one_rate(self.employee.id, benefit_detail)
        benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-DEP-PLUS-ONE")
        plan_choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
      end

      plan_choices_hash[benefit_detail.benefit_profile.provider_plan.to_sym] = plan_choices
    }
    plan_choices_hash
  end

  def select_choice!
    #raise ArgumentError, 'Choices collection has not been initialized' unless self.choices.present? && !self.choices.empty?
    return false unless self.valid?

    self.errors.add(:base, 'not implemented yet!!')
    
    selected_rate = choices.select{|choice| choice.selected }.first
    self.employee_benefit_selection.amount = selected_rate.amount
    benefit_selection_category = BenefitSelectionCategory.find_by(code: selected_rate.code)
    self.employee_benefit_selection.benefit_selection_category_id = benefit_selection_category.id
    self.employee_benefit_selection.save!

    # wrap record creation in a transaction...
    # create the employee benefit selection record...
    # and/or create the dependent selection records
    # return true if all succeeds!
    
  end

  private
  	def ensure_one_and_only_one_choice_selected
  	  return unless self.choices.present?

  	  employee_choices = self.choices.select {|choice| choice if choice.selected }
  	  if employee_choices.count > 1
  	  	self.errors.add(:base, 'Only one rate can be selected')
  	  end

  	  if employee_choices.count < 1
  	  	self.errors.add(:base, 'One rate must be selected')
  	  end
  	end
end