class PayrollRecordsController < ApplicationController
  # before_action :set_payroll_record, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :authorize_company!
  before_filter :authorize_manager!

  def index
    # @payroll_records = []
    @employees = find_company.employees.order(:last_name, :first_name).to_a
    # @employees.each {|employee|
    #   @payroll_records << PayrollRecord.new(employee_id: employee.id)
    # }
    # puts @payroll_records[0].employee_id
  end

  def show
  end

  def new
    @payroll_record = PayrollRecord.new
  end

  def edit
  end

  def create
    @payroll_record = PayrollRecord.new(payroll_record_params)

    respond_to do |format|
      if @payroll_record.save
        format.html { redirect_to @payroll_record, notice: 'Payroll record was successfully created.' }
        format.json { render :show, status: :created, location: @payroll_record }
      else
        format.html { render :new }
        format.json { render json: @payroll_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @payroll_record.update(payroll_record_params)
        format.html { redirect_to @payroll_record, notice: 'Payroll record was successfully updated.' }
        format.json { render :show, status: :ok, location: @payroll_record }
      else
        format.html { render :edit }
        format.json { render json: @payroll_record.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payroll_record.destroy
    respond_to do |format|
      format.html { redirect_to payroll_records_url, notice: 'Payroll record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # find company for current payroll records.
    def find_company
      Company.find(params[:company_id].to_i)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_payroll_record
      @payroll_record = PayrollRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payroll_record_params
      params.fetch(:payroll_record, {})
    end
end
