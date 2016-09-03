require "test_helper"

class EmployeeBenefitTest < ActiveSupport::TestCase
  def employee_benefit
    @employee_benefit ||= EmployeeBenefit.new
  end

  def test_valid
    assert employee_benefit.valid?
  end
end
