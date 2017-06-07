# use 'rails destroy controller Pages home' if replaced with other controller/specified dashboard
class PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :redirect_by_user_type!, only: [:home]

  def home
    if current_user.current_employee.present?
      @token = Swipeclock.authenticate(current_user.current_employee.id)
      @request_url = "https://clock.payrollservers.us/?enclosed=1&compact=1&showess=1&jwt=#{@token}"
    end
  end
  
  def invest

  end

  private
  	def redirect_by_user_type!
  		if current_user.manager?
  			redirect_to(companies_path(current_user.company_id))
  		elsif current_user.employee?
  			redirect_to(company_employee_path(current_user.company_id, current_user.employee_id))
  		end
  	end
end
