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

  test "generate payroll dates monthly with one payroll period" do
    # set the initial conditions
    initial

    payroll_count_before = PayrollPeriod.count

    expected_year = 2016
    expected_month = 9
    expected_day = 1

    PayrollPeriod.generate_payroll_dates(@company_id, 'monthly', @start_date, @num_periods, "%m/%d/%Y")

    # grab the last inserted row
    actual = PayrollPeriod.last

    payroll_count_after = PayrollPeriod.count

    assert_equal expected_year, actual.year
    assert_equal expected_month, actual.month
    assert_equal expected_day, actual.day
    assert_equal payroll_count_before + 1, payroll_count_after
  end

  test "generate payroll dates weekly with one payroll period" do
    # set the initial conditions
    initial

    payroll_count_before = PayrollPeriod.count

    expected_year = 2016
    expected_month = 8
    expected_day = 8

    PayrollPeriod.generate_payroll_dates(@company_id, 'weekly', @start_date, @num_periods, "%m/%d/%Y")

    # grab the last inserted row
    actual = PayrollPeriod.last

    payroll_count_after = PayrollPeriod.count

    assert_equal expected_year, actual.year
    assert_equal expected_month, actual.month
    assert_equal expected_day, actual.day
    assert_equal payroll_count_before + 1, payroll_count_after
  end

  test "generate payroll dates bi-weekly with one payroll period" do
    # set the initial conditions
    initial

    payroll_count_before = PayrollPeriod.count

    expected_year = 2016
    expected_month = 8
    expected_day = 15

    PayrollPeriod.generate_payroll_dates(@company_id, 'bi-weekly', @start_date, @num_periods, "%m/%d/%Y")

    # grab the last inserted row
    actual = PayrollPeriod.last

    payroll_count_after = PayrollPeriod.count

    assert_equal expected_year, actual.year
    assert_equal expected_month, actual.month
    assert_equal expected_day, actual.day
    assert_equal payroll_count_before + 1, payroll_count_after
  end
 
  test "generate payroll dates semi-monthly with one payroll period" do
    # set the initial conditions
    initial

    payroll_count_before = PayrollPeriod.count

    expected_year = 2016
    expected_month = 8
    expected_day = 16

    PayrollPeriod.generate_payroll_dates(@company_id, 'semi-monthly', @start_date, @num_periods, "%m/%d/%Y")

    # grab the last inserted row
    actual = PayrollPeriod.last

    payroll_count_after = PayrollPeriod.count

    assert_equal expected_year, actual.year
    assert_equal expected_month, actual.month
    assert_equal expected_day, actual.day
    assert_equal payroll_count_before + 1, payroll_count_after
  end
end
