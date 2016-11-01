# for each employee, using defined terms below, reconcile the health_invoice amount to
# the total company amount
class Reconciliation < ActiveRecord::Base

    # in the controller
    # @rows = Reconciliation.do_it(company_id)
    # then in the view iterate over the @rows variable and display the rows.

    def initialize(company_id, month, year)
        @company_id = company_id
        @company = Company.find(company_id)
        @month = month
        @year = year
    end

    def calculate
        results = []

        employees = @company.employees

        employees.each {|employee|
          if (employee.sub_id.present?)
              diff = calculate_diff(employee)
              results.push("#{employee.last_name}, #{employee.first_name} - Difference: #{diff}")
          else
              results.push("#{employee.last_name}, #{employee.first_name} - no sub_id")
          end
        }
        results
    end

    def calculate_diff(employee)
        emp_invoices = HealthInvoice.where(health_sub_id: employee.sub_id, month: @month, year: @year)

        return "No Invoices for month: #{@month} year: #{@year}" if emp_invoices.nil? || emp_invoices.count == 0

        # this grabs every payroll row for the specific employee for the specific month/year
        emp_payroll_deduction = PayrollDeduction.find_by(pay_sub_id: employee.sub_id, month: @month, year: @year)

        # we expect only one payroll per month (though this could be up to 5 payments aggregated)
        # we need to annualize the pay deductions to compare against the monthly invoice rates
        # so we need to look at the number of payroll periods to know how to annualize a monthly deduction

        # ultimately for a given month the difference should be zero.
        # but it might also be worth annualizing both the monthly invoice and payroll deduction and reporting those differences...


        if emp_payroll_deduction.nil?
            #return "No payroll deductions for month: #{@month} year: #{@year}"
            emp_payroll_deduction = 0
        end

        # get the account number from the invoices
        insurance_account_number = emp_invoices[0].account_number

        # benefit details for the employee
        benefit_selection = employee_benefit_selection(insurance_account_number, employee)
        return 'benefit declined' if benefit_selection.decline_benefit

        benefit_detail = BenefitDetail.find(benefit_selection.benefit_detail_id)

        # subscriber totals
        sub_invoice_total = health_invoice_sub_charges(emp_invoices)

        # dependent totals
        dep_invoice_total = health_invoice_dep_charges(emp_invoices)

        # employee deduction
        emp_deduction_amount = employee_deduction_amount(benefit_detail, emp_payroll_deduction)

        # employer contribution/pay
        employer_contribution = employer_contribution_sub(benefit_detail, sub_invoice_total) + employer_contribution_dep(benefit_detail, dep_invoice_total)


        # get the ee_deduction_converted
        # employee_contribution = ee_deduction_converted(employee, company)
        #employee_contribution = 50.00
        puts "-----------------------------------------------"
        puts "emp_payroll_deduction:#{emp_payroll_deduction}"
        puts "employer_contribution:#{employer_contribution}"
        puts "emp_deduction_amount:#{emp_deduction_amount}"
        puts "sub_invoice_total:#{sub_invoice_total}"
        puts "dep_invoice_total:#{dep_invoice_total}"
        puts "-----------------------------------------------"

        emp_deduction_amount + employer_contribution - sub_invoice_total - dep_invoice_total
    end

    def employee_benefit_selection(insurance_account_number, employee_id)
        benefit_profiles = @company.benefit_profiles.where(account_number: insurance_account_number)
        raise StandardError.new("No benefit_profiles found for insurance_account_number: #{insurance_account_number}") if benefit_profiles.count == 0
        raise StandardError.new("Should only have one benefit_profiles for a given insurance_account_number: #{insurance_account_number}") if benefit_profiles.count != 1

        benefit_profile = benefit_profiles.first
        benefit_selections = EmployeeBenefitSelection.where(employee_id: employee_id, benefit_type: benefit_profile.benefit_type)

        raise StandardError.new("No benefit_selection found for employee id: #{employee_id} insurance_account_number: #{insurance_account_number} benefit_type: #{benefit_profile.benefit_type}") if benefit_selections.count == 0
        raise StandardError.new("Should only have one benefit_selection for a given employee id: #{employee_id} insurance_account_number: #{insurance_account_number} benefit_type: #{benefit_profile.benefit_type}") if benefit_selections.count != 1
        benefit_selections.first
    end

    def health_invoice_sub_charges(emp_invoices)
        total = 0
        emp_invoices.each {|inv|
            total += inv.total_charges if inv.tier == 'SUB'
        }

        total
    end

    def health_invoice_dep_charges(emp_invoices)
        total = 0
        emp_invoices.each {|inv|
            total += inv.total_charges if inv.tier != 'SUB'
        }

        total
    end

    def employee_deduction_amount(employee_benefit_detail, payroll_deduction)
        case employee_benefit_detail.employee_tier
        when 'SUB', 'SPS', 'CH1', 'SPS1'
            payroll_deduction.deduction_amount
        else
            raise StandardError.new "#{employee_benefit_detail.employee_tier} does not match"
        end
    end

    def employer_contribution_sub(employee_benefit_detail, sub_invoice_total)
      
        if employee_benefit_detail.benefit_method == 'FIXED'
            employee_benefit_detail.category_sub
        else
            employee_benefit_detail.category_sub * sub_invoice_total  
        end
    end

    def employer_contribution_dep(employee_benefit_detail, dep_invoice_total)
        
        if employee_benefit_detail.benefit_method == 'FIXED'
            employee_benefit_detail.category_dep
        else
            employee_benefit_detail.category_dep * dep_invoice_total
        end
    end

    def self.do_it(company_id, month, year)
        reconciliation = Reconciliation.new(company_id: company_id, month: month, year: year)
        reconciliation.calculate
        # company = Company.find(company_id)
        # results = []

        # employees = company.employees

        # employees.each {|employee|
        #   diff = compute_employee_diff(company, employee)
        #   results.push("#{employee.last_name}, #{employee.first_name} Difference: #{diff}")
        # }
        # results
    end

    # def self.compute_employee_diff(company, employee)
    #     # this grabs every invoice row the specific employee
    #     emp_invoices = HealthInvoice.where(health_sub_id: employee.sub_id)

    #     return "No Invoices" if emp_invoices.nil? || emp_invoices.count == 0

    #     puts "sub_id: #{employee.sub_id} - #{emp_invoices}"

    #     # this grabs every payroll row the specific employee
    #     emp_payroll_deduction = PayrollDeduction.where(pay_sub_id: employee.sub_id).first

    #     # get the account number from the invoices
    #     insurance_account_number = emp_invoices[0].account_number

    #     # benefit details for the employee
    #     benefit_detail = employee_benefit_detail(company, insurance_account_number, employee)

    #     # sub totals
    #     sub_invoice_total = health_invoice_sub(emp_invoices)

    #     # dependent totals
    #     dep_invoice_total = health_invoice_dep(emp_invoices)

    #     # employee deduction
    #     emp_deduction_amount = employee_deduct_amount(benefit_detail, emp_payroll_deduction)

    #     # employer contribution/pay
    #     employer_contribution = employer_pay_sub(benefit_detail, sub_invoice_total) + employer_pay_dep(benefit_detail, dep_invoice_total)


    #     # get the ee_deduction_converted
    #     # employee_contribution = ee_deduction_converted(employee, company)
    #     #employee_contribution = 50.00
    #     puts "emp_payroll_deduction:#{emp_payroll_deduction}"
    #     puts "employer_contribution:#{employer_contribution}"
    #     puts "emp_deduction_amount:#{emp_deduction_amount}"
    #     puts "sub_invoice_total:#{sub_invoice_total}"
    #     puts "dep_invoice_total:#{dep_invoice_total}"

    #     emp_deduction_amount + employer_contribution - sub_invoice_total - dep_invoice_total
    # end

    # def self.employee_benefit_detail(company, insurance_account_number, employee)
    #     benefit_profiles = company.benefit_profiles.where(account_number: insurance_account_number)
    #     raise StandardError.new("No benefit_profiles found for insurance_account_number: #{insurance_account_number}") if benefit_profiles.count == 0
    #     raise StandardError.new("Should only have one benefit_profiles for a given insurance_account_number: #{insurance_account_number}") if benefit_profiles.count != 1

    #     benefit_profile = benefit_profiles.first
    #     benefit_selection = EmployeeBenefitSelection.where(employee_id: employee.id, benefit_type: benefit_profile.benefit_type).first
    #     return nil if benefit_selection.decline_benefit

    #     BenefitDetail.find(benefit_selection.benefit_detail_id)
    # end


    # # lookup health invoice for subscriber
    # # need date validation

    # def self.health_invoice_sub(emp_invoices)
    #     #HealthInvoice.where(tier: "SUB").sum(:total_charges)
    #     total = 0
    #     emp_invoices.each {|inv|
    #         total += inv.total_charges if inv.tier == 'SUB'
    #     }

    #     total
    # end

    # # lookup health invoice for dependent
    # # need date validation

    # def self.health_invoice_dep(emp_invoices)
    #     total = 0
    #     emp_invoices.each {|inv|
    #         total += inv.total_charges if inv.tier != 'SUB'
    #     }

    #     total
    # end

    # # employer pay for subscriber
    # def self.employer_pay_sub(employee_benefit_detail, sub_invoice_total)
      
    #     if employee_benefit_detail.benefit_method == 'FIXED'
    #         employee_benefit_detail.category_sub
    #     else
    #         employee_benefit_detail.category_sub * sub_invoice_total  
    #     end
    # end

    # # employer_pay_dep employer pay for dependents
    # def self.employer_pay_dep(employee_benefit_detail, dep_invoice_total)
        
    #     if employee_benefit_detail.benefit_method == 'FIXED'
    #         employee_benefit_detail.category_dep
    #     else
    #         employee_benefit_detail.category_dep * dep_invoice_total
    #     end
    # end

    # # #  employee_deduct_amount
    # def self.employee_deduct_amount(employee_benefit_detail, payroll_deduction)
    #     case employee_benefit_detail.employee_tier
    #     when 'SUB', 'SPS', 'CH1', 'SPS1'
    #         payroll_deduction.deduction_amount
    #     else
    #         0
    #     end
    # end

    # # # #  total_co_amount
    # # # #  Still need to address situation where er pays portion of dependent coverage
    # # def total_co_amount(employee)
        
    # #     # if employee(:subscriber_id).valid?
    # #     #     @total_co_amount = ""
    # #     # else
    # #         if employee.employee_tier != "DEP"
    # #             total_co_amount = (ee_deduction_converted + er_pay_sub)
    # #         else
    # #             if employee.employee_tier == "DEP"
    # #                 total_co_amount = "0"  #what about company pay of dep?
    # #             else
    # #                 total_co_amount = "NO MATCH"
    # #             end
    # #         end
    # # end

    # # # # Difference of total company amount and health invoice amount
    # # def difference
    # #   difference = health_invoice - total_co_amount  #need insurance.amount updated with csv reference
    # #   puts difference
    # # end


end
