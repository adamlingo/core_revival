class EmployeeBenefitSelection < ActiveRecord::Base
  belongs_to :employee
  belongs_to :benefit_detail

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
    benefit_profiles = BenefitProfile.where(company_id: company_id)
    return [] unless benefit_profiles.present?

    selections = []

    benefit_profiles.each { |benefit_profile|
      benefit_details = BenefitDetail.where(benefit_profile_id: benefit_profile.id)
      if benefit_details.present?
        benefit_details.each{ |benefit_detail|
          selections.push(EmployeeBenefitDetailSelection.new(benefit_profile, benefit_detail))
        }
      end
    }

    selections
  end
end