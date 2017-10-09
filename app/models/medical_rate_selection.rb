class MedicalRateSelection < ResourceModel::Base

  class RateChoice < ResourceModel::Base
    string_accessor :name # employee only, employee + spouse, etc...
    string_accessor :label
    string_accessor :code
    string_accessor :plan_name
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
  	dependents = Dependent.where(employee_id: self.employee.id, relationship: "dependent")
    spouse = Dependent.where(employee_id: self.employee.id, relationship: "spouse").first
    num_dependents = dependents.count

    self.benefit_details.each {|benefit_detail| 
      plan_choices = []
      benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB")
      rate = MedicalBenefitRate.compute_employee_rate(self.employee.id, benefit_detail)
      self.choices.push(RateChoice.new(plan_name: benefit_detail.benefit_profile.provider_plan, name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
      if spouse.present?
        rate = MedicalBenefitRate.compute_employee_spouse_rate(self.employee.id, benefit_detail)
        benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-SPS")
        self.choices.push(RateChoice.new(plan_name: benefit_detail.benefit_profile.provider_plan, name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
        if num_dependents > 0
          rate = MedicalBenefitRate.compute_employee_spouse_plus_one_rate(self.employee.id, benefit_detail)
          benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-SPS-PLUS-ONE")
          self.choices.push(RateChoice.new(plan_name: benefit_detail.benefit_profile.provider_plan, name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
        end
      end

      if num_dependents >= 1
        rate = MedicalBenefitRate.compute_employee_dependent_rate(self.employee.id, benefit_detail)
        benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-DEP")
        self.choices.push(RateChoice.new(plan_name: benefit_detail.benefit_profile.provider_plan, name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
      end

      if num_dependents >= 2 
        rate = MedicalBenefitRate.compute_employee_dependent_plus_one_rate(self.employee.id, benefit_detail)
        benefit_selection_category = BenefitSelectionCategory.find_by(code: "SUB-DEP-PLUS-ONE")
        self.choices.push(RateChoice.new(plan_name: benefit_detail.benefit_profile.provider_plan, name: benefit_selection_category.description, code: benefit_selection_category.code, amount: rate, label: rate.to_s, selected: false))
      end
    }
    self.choices
  end

  # def rate_choices_dto(plan_choices_hash)
  #   selection_categories = BenefitSelectionCategory.all.pluck(:code)
  #   dto = Hash.new
  #   plan_choices_hash.each {|plan_choice_key, plan_choice_values|
  #     puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  #     puts plan_choice_key
  #     puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  #     puts plan_choice_values 
  #     puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  #     selection_categories.each {|category|
  #       if dto[category.to_sym].present?
  #         category_values = dto[category.to_sym]
  #       else
  #         category_values = []
  #       end

  #       plan_choice_value = plan_choice_values.select{|rate_choice|
  #         rate_choice.code == category
  #       }.first
  #       if plan_choice_value.present?
  #         plan_choice_value.plan_name = plan_choice_key
  #         category_values.push(plan_choice_value)
  #       end

  #       dto[category.to_sym] = category_values
  #     }
  #   }
  #   puts "&&&&&&&&&&&&&&&&&&&&&&&"
  #   puts dto
  #   puts "&&&&&&&&&&&&&&&&&&&&&&&"
  #   dto
  # end

  def select_choice!
    return false unless self.valid?
    self.errors.add(:base, 'not implemented yet!!')
    false
    # selected_rate = choices.select{|choice| choice.selected }.first
    # # CREATE EMPLOYEE BENEFIT SELECTION RECORD TO SAVE AMOUNT TO
    # self.employee_benefit_selection.amount = selected_rate.amount
    # benefit_selection_category = BenefitSelectionCategory.find_by(code: selected_rate.code)
    # self.employee_benefit_selection.benefit_selection_category_id = benefit_selection_category.id
    # self.employee_benefit_selection.save!
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