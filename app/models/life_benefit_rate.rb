class LifeBenefitRate < ActiveRecord::Base
	belongs_to :benefit_detail
  validates_presence_of :benefit_detail_id

	def self.lookup_employee_rate_per_thousand(employee_id, benefit_detail_id)
		0.25
	end

	def self.lookup_spouse_rate_per_thousand(employee_id, benefit_detail_id)
		0.35
	end

	def self.lookup_dependent_rate(life_benefit_detail_id)
		0.45
	end

end
