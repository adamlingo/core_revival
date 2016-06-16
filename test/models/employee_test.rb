require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  def employee
    @employee ||= Employee.new
  end

end
