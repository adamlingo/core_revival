require "test_helper"

class TimeworkTest < ActiveSupport::TestCase
  def timework
    @timework ||= Timework.new
  end

  def test_valid
    assert timework.valid?
  end
end
