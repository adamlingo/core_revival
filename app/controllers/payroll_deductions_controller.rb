class PayrollDeductionsController < ApplicationController
  before_action :set_payroll_deduction, only: [:show, :edit, :update, :destroy]
  # before_filter :authenticate_user!

  # GET /payroll_deductions
  # GET /payroll_deductions.json
  def index
    @payroll_deductions = PayrollDeduction.all
  end

  # GET /payroll_deductions/1
  # GET /payroll_deductions/1.json
  def show
  end

  # GET /payroll_deductions/new
  def new
    @payroll_deduction = PayrollDeduction.new
  end

  # GET /payroll_deductions/1/edit
  def edit
  end

  # POST /payroll_deductions
  # POST /payroll_deductions.json
  def create
    @payroll_deduction = PayrollDeduction.new(payroll_deduction_params)

    respond_to do |format|
      if @payroll_deduction.save
        format.html { redirect_to @payroll_deduction, notice: 'Payroll deduction was successfully created.' }
        format.json { render :show, status: :created, location: @payroll_deduction }
      else
        format.html { render :new }
        format.json { render json: @payroll_deduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payroll_deductions/1
  # PATCH/PUT /payroll_deductions/1.json
  def update
    respond_to do |format|
      if @payroll_deduction.update(payroll_deduction_params)
        format.html { redirect_to @payroll_deduction, notice: 'Payroll deduction was successfully updated.' }
        format.json { render :show, status: :ok, location: @payroll_deduction }
      else
        format.html { render :edit }
        format.json { render json: @payroll_deduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payroll_deductions/1
  # DELETE /payroll_deductions/1.json
  def destroy
    @payroll_deduction.destroy
    respond_to do |format|
      format.html { redirect_to payroll_deductions_url, notice: 'Payroll deduction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payroll_deduction
      @payroll_deduction = PayrollDeduction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payroll_deduction_params
      params.fetch(:payroll_deduction, {})
    end
end
