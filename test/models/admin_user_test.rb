require "test_helper"

class AdminUserTest < ActiveSupport::TestCase
  def admin_user
    @admin_user ||= AdminUser.new
  end

  def test_valid
    assert admin_user.valid?
  end
end
