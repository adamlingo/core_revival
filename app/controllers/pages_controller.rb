# use 'rails destroy controller Pages home' if replaced with other controller/specified dashboard
class PagesController < ApplicationController
  before_filter :authenticate_user!

  def home
  end

end
