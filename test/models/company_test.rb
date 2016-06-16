require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  def company
    @company ||= Company.new
  end

end
