require "test_helper"

class EmployeesControllerTest < ActionController::TestCase
  
  # get new action to work
  def test_new
    # skip
    get :new
    assert_response :success
  end
end
