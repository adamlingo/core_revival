require "test_helper"

class BenefitRateTest < ActiveSupport::TestCase
  def benefit_rate
    @benefit_rate ||= BenefitRate.new
  end

  def test_valid
    assert benefit_rate.valid?
  end
end
