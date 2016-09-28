class EmployeeBenefitsController < ApplicationController
  # Empty new until decision on invitation vs. creation
  def new
  end
  
  def index
    @employee_benefits = EmployeeBenefit.all
    
  end


  
end
