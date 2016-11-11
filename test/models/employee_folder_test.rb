require "test_helper"

class EmployeeFolderTest < ActiveSupport::TestCase
  def employee_folder
    @employee_folder ||= EmployeeFolder.new
  end

end
