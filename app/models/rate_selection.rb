class RateSelection < ResourceModel::Base

  class RateChoice < ResourceModel::Base
    string_accessor :name # employee only, employee + spouse, etc...
    string_accessor :label # amount
    string_accessor :code 
    boolean_accessor :selected # is the checkbox is checked?
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

    sub_category = BenefitSelectionCategory.find_by(code: "SUB")
    rate = BenefitRate.compute_employee_rate(self.employee.id, self.employee_benefit_selection.id)
    self.choices.push(RateChoice.new(name: sub_category.description, code: sub_category.code, label: rate.to_s, selected: false))
    if spouse.present?
      sub_category = BenefitSelectionCategory.find_by(code: "SUB-SPS")
      self.choices.push(RateChoice.new(name: sub_category.description, code: sub_category.code, label: '386.52', selected: false))
      if num_dependents > 0
        sub_category = BenefitSelectionCategory.find_by(code: "SUB-SPS-PLUS-ONE")
        self.choices.push(RateChoice.new(name: sub_category.description, code: sub_category.code, label: '576.52', selected: false))
      end
    end

    if num_dependents == 1
      sub_category = BenefitSelectionCategory.find_by(code: "SUB-DEP")
  	  self.choices.push(RateChoice.new(name: sub_category.description, code: sub_category.code, label: '668.52', selected: false))
    elsif num_dependents > 1
      sub_category = BenefitSelectionCategory.find_by(code: "SUB-DEP-PLUS-ONE")
      self.choices.push(RateChoice.new(name: sub_category.description, code: sub_category.code, label: '145.52', selected: false))
    end
  end

  def select_choice!
    #raise ArgumentError, 'Choices collection has not been initialized' unless self.choices.present? && !self.choices.empty?
    return false unless self.valid?

    self.errors.add(:base, 'not implemented yet!!')
    puts "**************************"
    puts self.choices.to_s
    # selected = choices.selected # find choice where selected = true
    # benefit_selection_category = BenefitSelectionCategory.find_by(code: selected.code)
    # employee_benefit_selection.benefit_selection_category_id = benefit_selection_category.id
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
  	  	self.errors.add(:base, 'only one rate can be selected')
  	  end

  	  if employee_choices.count < 1
  	  	self.errors.add(:base, 'one rate must be selected')
  	  end
  	end
end