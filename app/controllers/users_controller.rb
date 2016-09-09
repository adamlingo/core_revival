class UsersController < ApplicationController
  # Empty new until decision on invitation vs. creation
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # need to add redirect for user type

    # creating a new user creates a new session
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/home'
    else
      redirect_to '/users/signup'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :manager)
    end
end
