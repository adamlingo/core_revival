require "test_helper"

class CompanyFolderTest < ActiveSupport::TestCase
  def company_folder
    @company_folder ||= CompanyFolder.new
  end

end
