require "test_helper"

class PagesControllerTest < ActionController::TestCase
  
  # setup is run automatically before every test, use instance var to reduce repitition across tests
  def setup
    @base_title = "Core Employee Solutions"
  end

  test "should get home" do
    get :home
    assert_response :success
    # check for title consistency in html:
    assert_select "title", "Home | #{@base_title}"
  end

end
