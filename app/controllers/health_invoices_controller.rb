class HealthInvoicesController < ApplicationController
  before_action :set_health_invoice, only: [:show, :edit, :update, :destroy]

  # GET /health_invoices
  # GET /health_invoices.json
  def index
    @health_invoices = HealthInvoice.all
  end

  # GET /health_invoices/1
  # GET /health_invoices/1.json
  def show
  end

  # GET /health_invoices/new
  def new
    @health_invoice = HealthInvoice.new
  end

  # GET /health_invoices/1/edit
  def edit
  end

  # POST /health_invoices
  # POST /health_invoices.json
  def create
    @health_invoice = HealthInvoice.new(health_invoice_params)

    respond_to do |format|
      if @health_invoice.save
        format.html { redirect_to @health_invoice, notice: 'Health invoice was successfully created.' }
        format.json { render :show, status: :created, location: @health_invoice }
      else
        format.html { render :new }
        format.json { render json: @health_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /health_invoices/1
  # PATCH/PUT /health_invoices/1.json
  def update
    respond_to do |format|
      if @health_invoice.update(health_invoice_params)
        format.html { redirect_to @health_invoice, notice: 'Health invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @health_invoice }
      else
        format.html { render :edit }
        format.json { render json: @health_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /health_invoices/1
  # DELETE /health_invoices/1.json
  def destroy
    @health_invoice.destroy
    respond_to do |format|
      format.html { redirect_to health_invoices_url, notice: 'Health invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_health_invoice
      @health_invoice = HealthInvoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def health_invoice_params
      params.fetch(:health_invoice, {})
    end
end
