class Reconciliation < ActiveRecord::Base

# for each employee, using defined terms below, reconcile the health_invoice amount to
# the total company amount

#employees.each do |ee, dif|
    #puts "#{ee} and #{diff}"
#end
    # in the controller
    # @rows = Reconciliation.do_it(company_id)
    # then in the view iterate over the @rows variable and display the rows.

    def self.do_it(company_id = 3)
        company = Company.find(company_id)
        results = []

        employees = Employee.where(company_id: company.id)

        employees.each {|employee|
          diff = compute_employee(employee)
          results.push("#{employee.name} Difference: #{diff}")
        }
        results
    end

    def self.compute_employee(employee)
        # this grabs every invoice row the specific employee
        emp_invoices = HealthInvoice.where(health_sub_id: employee.sub_id)

        # this grabs every payroll row the specific employee
        emp_payroll_deduction = PayrollDeduction.where(pay_sub_id: employee.sub_id).first

        # benefit details for the employee
        benefit_detail = employee_benefit_detail(employee)

        # sub totals
        sub_invoice_total = health_invoice_sub(emp_invoices)

        # dependent totals
        dep_invoice_total = health_invoice_dep(emp_invoices)

        # employee deduction
        emp_deduction_amount = ee_deduct_amount(benefit_detail, emp_payroll_deduction)

        # employer contribution/pay
        employer_contribution = er_pay_sub(benefit_detail, sub_invoice_total) + er_pay_dep(benefit_detail, dep_invoice_total)

        # get the ee_deduction_converted
        # employee_contribution = ee_deduction_converted(employee, company)
        employee_contribution = 50.00

        emp_deduction_amount + employee_contribution - sub_invoice_total - dep_invoice_total
    end

    def self.employee_benefit_detail(employee)
        BenefitDetail.where(employee_id: employee.id).first
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
        #health_invoice_dep = Health_invoice.where(tier: "DEP").sum(:total_charges)
        total = 0
        emp_invoices.each {|inv|
            total += inv.total_charges if inv.tier == 'DEP'
        }
        total
    end

    # define ee category
    def ee_category

        employee.employee_category
    end


    # defin employer pay for subscriber
    def self.er_pay_sub(employee_benefit_detail, sub_invoice_total)
      
        if employee_benefit_detail.benefit_method == 'FIXED'
            er_pay_sub = employee_benefit_detail.category_sub
        else
            er_pay_sub = employee_benefit_detail.category_sub * sub_invoice_total  
        end
    end

    # er_pay_dep employer pay for dependents
    def self.er_pay_dep(employee_benefit_detail, dep_invoice_total)
        
        if employee_benefit_detail.benefit_method == 'FIXED'
            employee_benefit_detail.category_dep
        else
            employee_benefit_detail.category_dep * dep_invoice_total
        end
    end

    # #  ee_deduct_amount
    def self.ee_deduct_amount(employee_benefit_detail, payroll_deduction)
        case employee_benefit_detail.employee_tier
        when 'SUB', 'SPS', 'CH1', 'SPS1'
            payroll_deduction.deduction_amount
        else
            0
        end

        
        # # if employee(:subscriber_id).valid?
        # #     @ee_deduct_amount = ""
        
        #      # if employee.employee_category == "NO MATCH"
        #         if employee.tier == "SUB" || employee.tier == "SPS" || employee.tier == "CH1" || employee.tier == "SPS1"
        #             ee_deduct_amount = Payroll_deduction.where().sum(:deduction_amount) 
        #             # pay_sub_id ?  How to lookup in above call?
        #         else
        #             ee_deduct_amount = "N/A-DEPENDENT"
        #         end
                
        #     # else 
                
        #     #     ee_deduct_amount = "NO MATCH"
    end

    #  ee_deduct_converted payroll.number from csv import
    def ee_deduction_converted(company)
            if payroll.number == 1 || payroll.number == 2 && company.pay_frequency == "Monthly" or "Semi-Monthly"
             ee_deduct_amount
             
            elsif payroll.number == 2 && company.pay_frequency == "Bi-Weekly"
             ee_deduct_amount / 2 * 26 / 12
             
            elsif payroll.number == 3 && company.pay_frequency == "Bi-Weekly"
             ee_deduct_amount / 3 * 26 / 12
             
            elsif payroll.number == 4 && company.pay_frequency == "Weekly"
             ee_deduct_amount / 4 * 52 / 12
             
            elsif payroll.number == 5 && company.pay_frequency == "Weekly"
             ee_deduct_amount / 5 * 52 / 12
             
            else
              ee_deduction_converted = ee_deduct_amount
            end
    end


    # #  total_co_amount
    # #  Still need to address situation where er pays portion of dependent coverage
    def total_co_amount(employee)
        
        # if employee(:subscriber_id).valid?
        #     @total_co_amount = ""
        # else
            if employee.employee_tier != "DEP"
                total_co_amount = (ee_deduction_converted + er_pay_sub)
            else
                if employee.employee_tier == "DEP"
                    total_co_amount = "0"  #what about company pay of dep?
                else
                    total_co_amount = "NO MATCH"
                end
            end
    end

    # # Difference of total company amount and health invoice amount
    def difference
            difference = health_invoice - total_co_amount  #need insurance.amount updated with csv reference
            puts difference
    end


end

# #  er_pay_amount

# def er_pay_amount
    
    # # if employee(:subscriber_id).valid?
    # #     @er_pay_amount = ""
 
    #     if ee_category.null?
            
    #         er_pay_amount == "NO MATCH"
           
    #         else if employee.benefit_method == "%"
#                 er_pay_amount = employee.category_sub * ee_invoice_amount
#             else
#                 er_pay_amount = employee.category_sub 
#                 # need to update with dep er amount
#             end
        
#         end
        
#     er_pay_amount
    
# end
# #  er_pay employer pay for subscriber
