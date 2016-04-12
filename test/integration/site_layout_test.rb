require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def test_sanity
    # flunk "Need real tests"
    get root_path
    # count is 1 for link in Home label
    assert_template 'pages/home'
    assert_select "a[href=?]", root_path, count: 1
    # Example of non-root path: Rails inserts help_path in place of ?
    # assert_select "a[href=?]", help_path
  end
end
