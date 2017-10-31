class LifeInsuranceRateSelectionController < ApplicationController
	
	def find		
		monthly_rate = compute_monthly_rate
		render :json => {monthly_rate: monthly_rate}, status: :ok

	end

	def compute_monthly_rate
		# desired_coverage_amount = params[:amount]
		# type = params[:type]
		# employee_id = params[:employee_id]
		# employee_benefit_selection_id = params[:employee_benefit_selection_id]
		123456
	end

	def validate_entry
		# howdy
		# duty
	end
end
