require "test_helper"

class PayrollPeriodTest < ActiveSupport::TestCase
  def payroll_period
    @payroll_period ||= PayrollPeriod.new
  end

  def test_valid
    assert payroll_period.valid?
  end
end
