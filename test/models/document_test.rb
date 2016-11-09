require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  def document
    @document ||= Document.new
  end

end
