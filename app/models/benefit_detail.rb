class BenefitDetail < ActiveRecord::Base
  belongs_to :benefit_profile

  def to_s
  	"id: #{self.id}\n"
  end
end
