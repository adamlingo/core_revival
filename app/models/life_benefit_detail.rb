class LifeBenefitDetail < ActiveRecord::Base
	belongs_to :benefit_detail
	has_many :life_cap_percentages
	
	validates_presence_of :benefit_detail_id

	def to_s
    "id: #{self.id}\n"
  end
end
