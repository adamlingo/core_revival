# for each employee, using defined terms below, reconcile the health_invoice amount to
# the total company amount
class Reconciliation < ActiveRecord::Base

    # in the controller
    # @rows = Reconciliation.do_it(company_id)
    # then in the view iterate over the @rows variable and display the rows.

    def self.do_it(company_id)
        company = Company.find(company_id)
        results = []

        employees = company.employees

        employees.each {|employee|
          diff = compute_employee_diff(company, employee)
          results.push("#{employee.last_name}, #{employee.first_name} Difference: #{diff}")
        }
        results
    end

    def self.compute_employee_diff(company, employee)
        # this grabs every invoice row the specific employee
        emp_invoices = HealthInvoice.where(health_sub_id: employee.sub_id)

        return "No Invoices" if emp_invoices.nil? || emp_invoices.count == 0

        puts "sub_id: #{employee.sub_id} - #{emp_invoices}"

        # this grabs every payroll row the specific employee
        emp_payroll_deduction = PayrollDeduction.where(pay_sub_id: employee.sub_id).first

        # get the account number from the invoices
        insurance_account_number = emp_invoices[0].account_number

        # benefit details for the employee
        benefit_detail = employee_benefit_detail(company, insurance_account_number, employee)

        # sub totals
        sub_invoice_total = health_invoice_sub(emp_invoices)

        # dependent totals
        dep_invoice_total = health_invoice_dep(emp_invoices)

        # employee deduction
        emp_deduction_amount = employee_deduct_amount(benefit_detail, emp_payroll_deduction)

        # employer contribution/pay
        employer_contribution = employer_pay_sub(benefit_detail, sub_invoice_total) + employer_pay_dep(benefit_detail, dep_invoice_total)


        # get the ee_deduction_converted
        # employee_contribution = ee_deduction_converted(employee, company)
        #employee_contribution = 50.00
        puts "emp_payroll_deduction:#{emp_payroll_deduction}"
        puts "employer_contribution:#{employer_contribution}"
        puts "emp_deduction_amount:#{emp_deduction_amount}"
        puts "sub_invoice_total:#{sub_invoice_total}"
        puts "dep_invoice_total:#{dep_invoice_total}"

        emp_deduction_amount + employer_contribution - sub_invoice_total - dep_invoice_total
    end

    def self.employee_benefit_detail(company, insurance_account_number, employee)
        benefit_profiles = company.benefit_profiles.where(account_number: insurance_account_number)
        raise StandardError.new("No benefit_profiles found for insurance_account_number: #{insurance_account_number}") if benefit_profiles.count == 0
        raise StandardError.new("Should only have one benefit_profiles for a given insurance_account_number: #{insurance_account_number}") if benefit_profiles.count != 1

        benefit_profile = benefit_profiles.first
        benefit_selection = EmployeeBenefitSelection.where(employee_id: employee.id, benefit_type: benefit_profile.benefit_type).first
        return nil if benefit_selection.decline_benefit

        BenefitDetail.find(benefit_selection.benefit_detail_id)
    end


    # lookup health invoice for subscriber
    # need date validation

    def self.health_invoice_sub(emp_invoices)
        #HealthInvoice.where(tier: "SUB").sum(:total_charges)
        total = 0
        emp_invoices.each {|inv|
            total += inv.total_charges if inv.tier == 'SUB'
        }

        total
    end

    # lookup health invoice for dependent
    # need date validation

    def self.health_invoice_dep(emp_invoices)
        total = 0
        emp_invoices.each {|inv|
            total += inv.total_charges if inv.tier != 'SUB'
        }

        total
    end

    # employer pay for subscriber
    def self.employer_pay_sub(employee_benefit_detail, sub_invoice_total)
      
        if employee_benefit_detail.benefit_method == 'FIXED'
            employee_benefit_detail.category_sub
        else
            employee_benefit_detail.category_sub * sub_invoice_total  
        end
    end

    # employer_pay_dep employer pay for dependents
    def self.employer_pay_dep(employee_benefit_detail, dep_invoice_total)
        
        if employee_benefit_detail.benefit_method == 'FIXED'
            employee_benefit_detail.category_dep
        else
            employee_benefit_detail.category_dep * dep_invoice_total
        end
    end

    # #  employee_deduct_amount
    def self.employee_deduct_amount(employee_benefit_detail, payroll_deduction)
        case employee_benefit_detail.employee_tier
        when 'SUB', 'SPS', 'CH1', 'SPS1'
            payroll_deduction.deduction_amount
        else
            0
        end
    end

    # # #  total_co_amount
    # # #  Still need to address situation where er pays portion of dependent coverage
    # def total_co_amount(employee)
        
    #     # if employee(:subscriber_id).valid?
    #     #     @total_co_amount = ""
    #     # else
    #         if employee.employee_tier != "DEP"
    #             total_co_amount = (ee_deduction_converted + er_pay_sub)
    #         else
    #             if employee.employee_tier == "DEP"
    #                 total_co_amount = "0"  #what about company pay of dep?
    #             else
    #                 total_co_amount = "NO MATCH"
    #             end
    #         end
    # end

    # # # Difference of total company amount and health invoice amount
    # def difference
    #   difference = health_invoice - total_co_amount  #need insurance.amount updated with csv reference
    #   puts difference
    # end


end
