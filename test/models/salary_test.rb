require "test_helper"

class SalaryTest < ActiveSupport::TestCase
  def salary
    @salary ||= Salary.new
  end

  def test_valid
    assert salary.valid?
  end
end
