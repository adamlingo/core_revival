class RateSelection < ResourceModel::Base

  class RateChoice < ResourceModel::Base
    string_accessor :name # employee only, employee + spouse, etc...
    string_accessor :label
    string_accessor :code 
    boolean_accessor :selected # is the checkbox is checked?
    attr_accessor :amount
  end

  has_associated_model :employee
  has_associated_model :employee_benefit_selection
  has_associated_resource_model_collection :choices, class_name: 'RateChoice'

  validate :ensure_one_and_only_one_choice_selected

  def init(attributes)
    super(attributes)
  end

  def build_choices!
  	self.choices = []
  	return unless self.employee.benefit_eligible
 
  	dependents = Dependent.where(employee_id: self.employee.id, relationship: "dependent")
    spouse = Dependent.where(employee_id: self.employee.id, relationship: "spouse").first
    num_dependents = dependents.count

    benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB")
    rate = BenefitRate.compute_employee_rate(self.employee.id, self.employee_benefit_selection.id)
    self.choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
    if spouse.present?
      rate = BenefitRate.compute_employee_spouse_rate(self.employee.id, self.employee_benefit_selection.id)
      benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-SPS")
      self.choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
      if num_dependents > 0
        rate = BenefitRate.compute_employee_spouse_plus_one_rate(self.employee.id, self.employee_benefit_selection.id)
        benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-SPS-PLUS-ONE")
        self.choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
      end
    end

    if num_dependents >= 1
      rate = BenefitRate.compute_employee_dependent_rate(self.employee.id, self.employee_benefit_selection.id)
      benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-DEP")
  	  self.choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
    end

    if num_dependents >= 2 
      rate = BenefitRate.compute_employee_dependent_plus_one_rate(self.employee.id, self.employee_benefit_selection.id)
      benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-DEP-PLUS-ONE")
      self.choices.push(RateChoice.new(name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
    end
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