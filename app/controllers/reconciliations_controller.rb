class ReconciliationsController < ApplicationController

  def index
    company_id = params[:company_id]
    @company = Company.find(company_id)
    @health_invoices = []

    BenefitProfile.where(company_id: company_id).each { |benefit_profile|
      invoices = HealthInvoice.where(account_number: benefit_profile.account_number)
      @health_invoices + invoices
    }
  end

  def calculate
    company_id = params[:company_id]
    @company = Company.find(company_id)
    @reconciliations = Reconciliation.do_it(company_id)

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reconciliation_params
      params.permit(:company_id)
    end
end
