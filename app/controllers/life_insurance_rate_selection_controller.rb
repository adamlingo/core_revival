class LifeInsuranceRateSelectionController < ApplicationController
	
	def find
		render :json => {amount: "my amount"}, :status :ok
	end
end
