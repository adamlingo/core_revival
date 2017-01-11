require "test_helper"

class DependentTest < ActiveSupport::TestCase
  def dependent
    @dependent ||= Dependent.new
  end

  def test_valid
    assert dependent.valid?
  end
end
