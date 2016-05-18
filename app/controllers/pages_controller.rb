# use 'rails destroy controller Pages home' if replaced with other controller/specified dashboard
class PagesController < ApplicationController
  before_filter :authenticate_user!

  def home
  end

  # temp space for loading companies
  def companies_static
    @users = User.all
    @companies = Company.all 
  end
end
