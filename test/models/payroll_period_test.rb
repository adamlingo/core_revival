require "test_helper"

class PayrollPeriodTest < ActiveSupport::TestCase
  def payroll_period
    @payroll_period ||= PayrollPeriod.new
  end

  def initial
    @company_id = 1
    @start_date = "08/01/2016"
    @num_periods = 1
  end
 # test monthly is next month
 
  def test_monthly_with_one_payroll_period
    # set the initial conditions
    initial

    payroll_count_before = PayrollPeriod.count

    expected_year = 2016
    expected_month = 8
    expected_day = 1

    PayrollPeriod.generate_monthly(@company_id, @start_date, @num_periods)

    # grab the last inserted row
    actual = PayrollPeriod.last

    payroll_count_after = PayrollPeriod.count

    assert_equal expected_year, actual.year
    assert_equal expected_month, actual.month
    assert_equal expected_day, actual.day
    assert_equal payroll_count_before + 1, payroll_count_after
  end
 
end
