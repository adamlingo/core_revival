# use 'rails destroy controller Pages home' if replaced with other controller/specified dashboard
class PagesController < ApplicationController
  before_filter :authenticate_user!

  def home
    if current_user.current_employee.present?
      @token = Swipeclock.authenticate(current_user.current_employee.id)
      @request_url = "https://clock.payrollservers.us/?enclosed=1&compact=1&showess=1&jwt=#{@token}"
    end
  end
  
  

end
