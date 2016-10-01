require "test_helper"

class EmployeeAdditionalLoginTest < ActiveSupport::TestCase
  def employee_additional_login
    @employee_additional_login ||= EmployeeAdditionalLogin.new
  end

  def test_valid
    assert employee_additional_login.valid?
  end
end
