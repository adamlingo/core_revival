require "test_helper"

class CompanyPayrollDateTest < ActiveSupport::TestCase
  def company_payroll_date
    @company_payroll_date ||= CompanyPayrollDate.new
  end

  def test_valid
    skip
    #assert company_payroll_date.valid?
  end
end
