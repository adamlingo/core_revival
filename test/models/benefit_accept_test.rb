require "test_helper"

class BenefitAcceptTest < ActiveSupport::TestCase
  def benefit_accept
    @benefit_accept ||= BenefitAccept.new
  end

  def test_valid
    assert benefit_accept.valid?
  end
end
