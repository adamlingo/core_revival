require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  def company
    @company ||= Company.new
  end

  def test_valid
    assert company.valid?
  end
end
