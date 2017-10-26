class UsersController < ApplicationController
  # Empty new until decision on invitation vs. creation
  def index
    if current_user.admin?
    	@users = User.all
    else
    	flash[:error] = "You aren't allowed to view this page"
    	redirect_to root_path
    end
    # used in future for showing all users
    # controllers/users/ is where devise controllers exist
  end
end
