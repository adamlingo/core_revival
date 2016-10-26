require 'csv'

namespace :reconciliation do

desc "reconciliation development"

  task calculate:  :environment do
    FILE_NAME_WITH_REAL_DEDUCTION_DATA='Deduction_Register_Subscriber_BCBS_-_14917935.csv'.freeze
    PATH_TO_ACTUAL_DEDUCTION_FILE = "#{Rails.root}/test/fixtures/#{FILE_NAME_WITH_REAL_DEDUCTION_DATA}".freeze
    FILE_NAME_WITH_REAL_INVOICE_DATA='0000167878_08-01-2016_09-01-2016.csv'.freeze
    PATH_TO_ACTUAL_INVOICE_FILE = "#{Rails.root}/test/fixtures/#{FILE_NAME_WITH_REAL_INVOICE_DATA}".freeze


    PayrollDeduction.delete_all
    deduction_file = File.new(PATH_TO_ACTUAL_DEDUCTION_FILE)
    PayrollDeduction.import(deduction_file, 8, 2016)

    HealthInvoice.delete_all
    invoice_file = File.new(PATH_TO_ACTUAL_INVOICE_FILE)
    HealthInvoice.import(invoice_file)

    employees = Company.find(3).employees
    employees.each {|e|
        payroll_deduction = PayrollDeduction.find_by(pay_sub_id: e.sub_id)
        if payroll_deduction.present?
            #puts "YAY! DEDUCTIONS FOR #{e.sub_id}"
            payroll_deduction.month = 8 if payroll_deduction.month.nil?
            payroll_deduction.year = 2016 if payroll_deduction.year.nil?
            payroll_deduction.save!
        else
            #puts "NO EFFIN DEDUCTIONS FOR #{e.sub_id}"
        end

        benefit_selection = EmployeeBenefitSelection.where(employee_id: e.id)
        if benefit_selection.present?
            #puts "YAY! benefit_selection FOR id: #{e.id}, sub_id: #{e.sub_id}"
        else
            #puts "BOO! No benefit_selection FOR id: #{e.id}, sub_id: #{e.sub_id}"
        end

    }

    reconciliation = Reconciliation.new(3, 8, 2016)
    results = reconciliation.calculate
    puts results
  end
  
end
    


  
  
