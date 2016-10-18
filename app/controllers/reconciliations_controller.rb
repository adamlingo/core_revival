class ReconciliationsController < ApplicationController
  respond_to :html, :js, only: [:import_health_invoices, :import_payroll_deductions]
  protect_from_forgery with: :null_session, only: [:import_health_invoices, :import_payroll_deductions]

  def index
    company_id = params[:company_id]
    @company = Company.find(company_id)
    @health_invoices = []
    @payroll_deductions = []

    # BenefitProfile.where(company_id: company_id).each { |benefit_profile|
    #   invoices = HealthInvoice.where(account_number: benefit_profile.account_number)
    #   @health_invoices + invoices
    # }
  end

  def calculate
    company_id = params[:company_id]
    @company = Company.find(company_id)
    @reconciliations = Reconciliation.do_it(company_id)
  end

  def import_health_invoices
    upload_file = params[:file]
    @health_invoices = HealthInvoice.import(upload_file)
    puts @health_invoices
  end

  def import_payroll_deductions
    upload_file = params[:file]
    @payroll_deductions = PayrollDeduction.import(upload_file)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reconciliation_params
      params.permit(:company_id)
    end
end
