require "test_helper"

class EmployeeBenefitSelectionTest < ActiveSupport::TestCase
  def employee_benefit_selection
    @employee_benefit_selection ||= EmployeeBenefitSelection.new
  end

  def test_valid
    assert employee_benefit_selection.valid?
  end
end
