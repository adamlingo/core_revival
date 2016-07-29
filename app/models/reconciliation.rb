class Reconciliation < ActiveRecord::Base

# for each employee, using defined terms below, reconcile the health_invoice amount to
# the total company amount

employees.each do |ee, dif|
    puts "#{ee} and #{diff}"
end


# ee_category

def employee
    employee = Employee.benefit_detail
end


# lookup health invoice for subscriber
# need date validation

def health_invoice_sub
  
    health_invoice_sub = Health_invoice.where(tier: "SUB").sum(:amount)
end

# lookup health invoice for dependent
# need date validation

def health_invoice_dep
  
    health_invoice_dep = Health_invoice.where(tier: "DEP").sum(:amount)
end

# define ee category
def ee_category

    employee.employee_category
end


# defin employer pay for subscriber
def er_pay_sub
  
    if employee.benefit_method == "FIXED"
        er_pay_sub = employee.category_sub
    else
         er_pay_sub = employee.category_sub * health_invoice  
    end
end

# er_pay_dep employer pay for dependents
def er_pay_dep
    
    if employee.benefit_method == "FIXED"
        er_pay_dep = employee.category_dep
    else
        er_pay_dep = employee.category_dep * health_invoice
    end
end

# #  ee_deduct_amount
def ee_deduct_amount
    
    # if employee(:subscriber_id).valid?
    #     @ee_deduct_amount = ""
    
         # if employee.employee_category == "NO MATCH"
            if employee.tier == sub or sps or ch1 or sps1
                # look up subscriber_id in payroll import and return sum of deductions
            else
                ee_deduct_amount = "N/A-DEPENDENT"
            end
            
        else 
            
            ee_deduct_amount = "NO MATCH"
end

#  ee_deduct_converted payroll.number from csv import
def ee_deduction_converted
        if payroll.number == 1 or 2 && Company.pay_frequency == "Monthly" or "Semi-Monthly"
         ee_deduction_converted = ee_deduct_amount
         
        else if payroll.number == 2 && Company.pay_frequency == "Bi-Weekly"
         ee_deduction_converted = ee_deduct_amount / 2 * 26 / 12
         
        else if payroll.number == 3 && Company.pay_frequency == "Bi-Weekly"
         ee_deduction_converted = ee_deduct_amount / 3 * 26 / 12
         
        else if payroll.number == 4 && Company.pay_frequency == "Weekly"
         ee_deduction_converted = ee_deduct_amount / 4 * 52 / 12
         
        else if payroll.number == 5 && Company.pay_frequency == "Weekly"
         ee_deduction_converted = ee_deduct_amount / 5 * 52 / 12
         
        else ee_deduction_converted = ee_deduct_amount
        end
end


# #  total_co_amount
# #  Still need to address situation where er pays portion of dependent coverage
def total_co_amount
    
    # if employee(:subscriber_id).valid?
    #     @total_co_amount = ""
    # else
        if employee.employee_tier != "DEP"
            total_co_amount = (ee_deduction_converted + er_pay)
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
