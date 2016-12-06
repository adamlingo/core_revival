class ReconciliationsController < ApplicationController

  def index
    helper_attributes = {
      company_id: params[:company_id],
      month: params[:month],
      year: params[:year]      
    }

    @helper = ReconciliationHelper.new(helper_attributes)
    if @helper.valid? && @helper.check_for_records!
      flash[:info] = 'Ready to calculate reconciliations!'
    else
      flash[:error] = "Unable to process reconciliations: #{@helper.errors.full_messages.to_sentence}"
    end

    @health_invoices = []
    @payroll_deductions = []
  end

  def calculate
    calculator_attributes = {
      company_id: params[:company_id],
      month: params[:month],
      year: params[:year]      
    }
    @helper = ReconciliationHelper.new(calculator_attributes)
    if @helper.valid? && @helper.check_for_records!
      flash[:error] = ''
      calculator = ReconciliationCalculator.new(calculator_attributes)
      if calculator.valid? && calculator.calculate!
        flash[:info] = 'Reconciliations calculated!'
        flash[:error] = ''
        @reconciliations = calculator.reconciliations
      else
        flash[:error] = "Unable to process reconciliations: #{calculator.errors.full_messages.to_sentence}"
        redirect_to company_index_url(calculator_attributes)
      end
    else
      flash[:error] = "Unable to process reconciliations: #{@helper.errors.full_messages.to_sentence}"
      redirect_to company_index_url(calculator_attributes)
    end
  end

  def import_health_invoices
    importer_attributes = {
      company_id: params[:company_id],
      month: params[:month],
      year: params[:year]      
    }
    importer = HealthInvoicesImporter.new(importer_attributes)

    upload_file = params[:file]

    if importer.valid? && importer.import!(upload_file)
      message = "Health invoices imported successfully!"
      flash[:info] = message
    else
      message = "Unable to import health invoices: #{importer.errors.full_messages.to_sentence}"
      flash[:error] = message
    end

    redirect_to company_index_url(importer_attributes), notice: message
  end

  def import_payroll_deductions
    importer_attributes = {
      company_id: params[:company_id],
      month: params[:month],
      year: params[:year]      
    }
    importer = PayrollDeductionsImporter.new(importer_attributes)

    upload_file = params[:file]

    if importer.valid? && importer.import!(upload_file)
      message = "Payroll deductions imported successfully!"
      flash[:info] = message
    else
      message = "Unable to import payroll deductions: #{importer.errors.full_messages.to_sentence}"
      flash[:error] = message
    end

    redirect_to company_index_url(importer_attributes)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reconciliation_params
      params.permit(:company_id)
    end

end
