class LifeRateSelection < ResourceModel::Base
	
	string_accessor :type
	attr_accessor :choices

	has_associated_model :employee
  has_associated_model :employee_benefit_selection

	def init(attributes)
	  super(attributes)
	  self.type = "Life"
	  self.choices = []
	end

  def build_choices!
  	# self.choices = []
  	# return unless self.employee.benefit_eligible
  	[]
  end
end