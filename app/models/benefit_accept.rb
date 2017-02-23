class BenefitAccept < ActiveRecord::Base

  belongs_to :benefit_profile
  validates_presence_of :benefit_profile_id
    
  def new
  end

end
