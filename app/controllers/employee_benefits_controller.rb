class EmployeeBenefitsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :authorize_company!
  # Empty new until decision on invitation vs. creation
  def new
  end
  
  def index
    @employee_benefits = EmployeeBenefit.all
    company = Company.find(params[:company_id].to_i)
    @employees = company.employees
	end


  
end
