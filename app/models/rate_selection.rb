class RateSelection < ResourceModel::Base

  class RateChoice < ResourceModel::Base
    string_accessor :name # employee only, employee + spouse, etc...
    string_accessor :label # amount
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
  	self.choices.push(RateChoice.new(name: 'Employee only', label: '286.52', selected: false))
  	self.choices.push(RateChoice.new(name: 'Employee plus spouse', label: '386.52', selected: false))
  	self.choices.push(RateChoice.new(name: 'Employee plus child', label: '486.52', selected: false))
  end

  def select_choice!
    #raise ArgumentError, 'Choices collection has not been initialized' unless self.choices.present? && !self.choices.empty?
    return false unless self.valid?

    self.errors.add(:base, 'not implemented yet!!')
    false
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