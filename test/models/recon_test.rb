require "test_helper"

class ReconTest < ActiveSupport::TestCase
  def recon
    @recon ||= Recon.new
  end

  def test_valid
    assert recon.valid?
  end
end
