require "test_helper"

class BenefitProfileTest < ActiveSupport::TestCase
  def benefit_profile
    @benefit_profile ||= BenefitProfile.new
  end

end
