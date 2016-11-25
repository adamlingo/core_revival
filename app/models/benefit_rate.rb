class BenefitRate < ActiveRecord::Base
    belongs_to :benefit_detail
    validates_presence_of :benefit_detail_id
    
    
    
    def new
    end
    
    def self.compute_rate
    end
    
    def self.import
    end
    
end
