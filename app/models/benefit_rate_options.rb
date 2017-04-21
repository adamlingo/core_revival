class BenefitRateOptions < ResourceModel::Base
  has_associated_model :employee
  # different calculation methods for form listed here:
  attr_accessor :employee_only
  attr_accessor :employee_plus_spouse
  attr_accessor :employee_plus_dependent
  attr_accessor :employee_plus_multiple_dependents
  attr_accessor :employee_plus_family_one
  attr_accessor :employee_plus_family_two

  validates_presence_of :employee

  def initialize(attributes = {})
    super(attributes)
  end

  def compute_rates!
    raise StandardError.new('Not valid') unless self.valid?
  end
end