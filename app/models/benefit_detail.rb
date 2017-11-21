class BenefitDetail < ActiveRecord::Base
  belongs_to :benefit_profile
  has_many :benefit_rates
  has_many :life_benefit_details
  
  validates_presence_of :benefit_profile_id
  
  def to_s
    "id: #{self.id}\n"
  end
end
