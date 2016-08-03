require "test_helper"

class PayrollDeductionTest < ActiveSupport::TestCase
  def payroll_deduction
    @payroll_deduction ||= PayrollDeduction.new
  end

  def test_valid
    assert payroll_deduction.valid?
  end
end
