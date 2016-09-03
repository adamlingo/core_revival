require "test_helper"

class PayrollPeriodWeeklyTest < ActiveSupport::TestCase
  def payroll_period
    @payroll_period ||= PayrollPeriod.new
  end


  test "generate payroll dates weekly with one payroll period" do
    company_id = 1
    start_date = "08/01/2016"
    num_periods = 1

    payroll_count_before = PayrollPeriod.count

    expected_year = 2016
    expected_month = 8
    expected_day = 8
    expected_pay_period = 'weekly'

    PayrollPeriod.generate_payroll_dates(company_id, 'weekly', start_date, num_periods, "%m/%d/%Y")

    # grab the last inserted row
    actual = PayrollPeriod.last

    payroll_count_after = PayrollPeriod.count

    assert_equal expected_year, actual.year
    assert_equal expected_month, actual.month
    assert_equal expected_day, actual.day
    assert_equal expected_pay_period, actual.pay_period
    assert_equal payroll_count_before + num_periods, payroll_count_after
  end

  test "generate payroll dates weekly for one year (52 pay periods)" do
    company_id = 1
    start_date = "08/01/2016"
    num_periods = 52

    payroll_count_before = PayrollPeriod.count

    expected_year = 2017
    expected_month = 7
    expected_day = 31
    expected_pay_period = 'weekly'

    PayrollPeriod.generate_payroll_dates(company_id, 'weekly', start_date, num_periods, "%m/%d/%Y")

    # grab the last inserted row
    actual = PayrollPeriod.last

    payroll_count_after = PayrollPeriod.count

    assert_equal expected_year, actual.year
    assert_equal expected_month, actual.month
    assert_equal expected_day, actual.day
    assert_equal expected_pay_period, actual.pay_period
    assert_equal payroll_count_before + num_periods, payroll_count_after
  end
end
