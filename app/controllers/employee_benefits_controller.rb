class EmployeeBenefitsController < ApplicationController
    before_filter :authenticate_user!
    # before_filter :authenticate_manager!
  # Empty new until decision on invitation vs. creation
  def new
  end
  
  def index
    @employee_benefits = EmployeeBenefit.all
  end


  
end
