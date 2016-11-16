class PayrollRecordsController < ApplicationController
  # before_action :set_payroll_record, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :authorize_company!
  before_filter :authorize_manager!

  def index
    @employees = find_company.employees.order(:last_name, :first_name).to_a
    
  end

  def show
  end

  def new
    @payroll_record = PayrollRecord.new
  end

  def edit
  end

  def create
    @employees = find_company.employees
    
    # pluck ids from company's employees
    @employee_ids = @employees.where(company_id: params[:company_id]).pluck(:id)
    puts "**** START TABLE INFO ****"
    @employee_ids.each {|employee_id|
      # create new PayrollRecord for each EE in table
      payroll_record = PayrollRecord.new(employee_id: employee_id, company_id: find_company.id,
                                        reg_hours: (params["#{employee_id}-reg_hours"].to_f),
                                        ot_hours:  (params["#{employee_id}-ot_hours"].to_f),
                                        other_pay: (params["#{employee_id}-other_pay"].to_f),
                                        sick_hours:(params["#{employee_id}-sick_hours"].to_f),
                                        vacation_hours:(params["#{employee_id}-vacation_hours"].to_f),
                                        holiday_hours: (params["#{employee_id}-holiday_hours"].to_f),
                                        memo: (params["#{employee_id}-memo"]))
      # puts statements for console = data lines up with correct employee
      puts Employee.find(employee_id).last_name
      puts employee_id
      print "reg_hours as entered in form: "
      puts params["#{employee_id}-reg_hours"]
      print "reg_hours in payroll_record: "
      puts payroll_record.reg_hours

      payroll_record.save
      # reload after save...
      payroll_record.reload
      puts "reg_hours AFTER save: #{payroll_record.reg_hours}"
      puts "*******************"
    }
    flash[:success] = "Payroll Successfully Submitted"
    # after save, return to index/table view
    redirect_to company_payroll_records_path
  end

  def update
    
  end

  def destroy
    
  end

  private
    # find company for current payroll records.
    def find_company
      Company.find(params[:company_id].to_i)
    end
    # SET PARAMS HERE IF NEEDED FOR SECURITY

    # Never trust parameters from the scary internet, only allow the white list through.
    # def payroll_record_params
    #   params.fetch(:payroll_record, {})
    # end
end
