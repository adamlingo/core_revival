class UsersController < ApplicationController
  # Empty new until decision on invitation vs. creation
  def index
    @users = User.all
    # used in future for showing all users
    # controllers/users/ is where devise controllers exist
  end

end
