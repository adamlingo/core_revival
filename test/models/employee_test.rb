require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  def employee
    @employee ||= Employee.new
  end

  def test_valid
    assert employee.valid?
  end
end
