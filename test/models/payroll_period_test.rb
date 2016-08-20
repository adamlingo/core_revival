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
 
 def test_monthly
   expected = "09/01/2016"
   
   actual = PayrollPeriod.generate_monthly(company_id, start_date, num_periods)
   
   assert equal expected, actual
 end
 
end
