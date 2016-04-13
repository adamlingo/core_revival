require "test_helper"
# use app/test/test_helper.rb

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  # tests that all links are valid/used in layouts/application.html.erb
  def test_layout_links
    get root_path
    assert_template 'pages/home'
    # count is 1 for links in Home page to root
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", companies_path
    # Example of non-root path: Rails inserts help_path in place of ?
    # assert_select "a[href=?]", help_path
  end

end
