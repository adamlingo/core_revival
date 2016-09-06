class UsersController < ApplicationController
  # Empty new until decision on invitation vs. creation
  def index
  end

  def new
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :employee, :manager)
    end
end
