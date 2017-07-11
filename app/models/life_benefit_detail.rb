class LifeBenefitDetail < ActiveRecord::Base
	belongs_to :benefit_detail

	validates_presence_of :benefit_detail_id

	def to_s
    "id: #{self.id}\n"
  end
end
