module EmployeeBenefitSelectionsHelper
  def perty_benefit_profiles
    BenefitProfile.where(company_id: params[:company_id]).pluck(:provider, :provider_plan, :benefit_type, :id)
  end
end
