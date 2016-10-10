class EmployeeBenefitSelection < ActiveRecord::Base
  belongs_to :employee
  belongs_to :benefit_detail
  validates_presence_of :benefit_type
  validates :benefit_detail_id, :presence => true, :unless => :is_benefit_declined?
  before_save :unset_benefit_detail_if_declined



  private
    def unset_benefit_detail_if_declined
      self.benefit_detail_id = nil if self.decline_benefit
    end  
    def is_benefit_declined?
      self.decline_benefit
    end
end


class EmployeeBenefitDetailSelection
  attr_accessor :benefit_detail_id
  attr_accessor :display_name

  def initialize(benefit_profile, benefit_detail)
    display_name = "#{benefit_detail.employee_category}: #{benefit_profile.benefit_type} - #{benefit_profile.provider} #{benefit_profile.provider_plan}"

    @benefit_detail_id = benefit_detail.id
    @display_name = display_name
  end

  def self.get_choices(company_id)
  	benefit_detail_options = []
    benefit_profiles = BenefitProfile.where(company_id: company_id)
    return benefit_detail_options unless benefit_profiles.present?

    benefit_profiles.each { |benefit_profile|
      benefit_details = BenefitDetail.where(benefit_profile_id: benefit_profile.id)
      if benefit_details.present?
        benefit_details.each{ |benefit_detail|
          benefit_detail_options.push(EmployeeBenefitDetailSelection.new(benefit_profile, benefit_detail))
        }
      end
    }

    benefit_detail_options
  end

  def self.get_benefit_types(company_id)
    benefit_types = ['']
    benefit_profiles = BenefitProfile.where(company_id: company_id)
    return benefit_types unless benefit_profiles.present?

    benefit_profiles.each { |benefit_profile|
      benefit_types.push(benefit_profile.benefit_type)
    }

    benefit_types
  end
end