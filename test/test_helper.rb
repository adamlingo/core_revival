ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# Add minitest for green/red pass/fail
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # use ApplicationHelper in all tests
  include ApplicationHelper
  # avoid test errors like "undefined method 'authenticate' "
  # include Devise::TestHelpers
  # Add more helper methods to be used by all tests here...
end
