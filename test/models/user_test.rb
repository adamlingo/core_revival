require "test_helper"

class UserTest < ActiveSupport::TestCase
  def user
    @user ||= User.new
  end

  # write test for valid user here soon
  # def test_valid
  #   assert user.valid?
  # end
end
