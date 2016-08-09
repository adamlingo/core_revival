class Reconciliation < ActiveRecord::Base

# for each employee, using defined terms below, reconcile the health_invoice amount to
# the total company amount

employees.each do |ee, dif|
    puts "#{ee} and #{diff}"
end


# ee_category

def employee
    @employee = Employee.benefit_detail
end


# lookup health invoice for subscriber
# need date validation

def health_invoice_sub
  
    @health_invoice_sub = Health_invoice.where(tier: "SUB").sum(:total_charges)
end

# lookup health invoice for dependent
# need date validation

def health_invoice_dep
  
    @health_invoice_dep = Health_invoice.where(tier: "DEP").sum(:total_charges)
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
         er_pay_sub = employee.category_sub * health_invoice_sub
         
    end
end

# er_pay_dep employer pay for dependents
def er_pay_dep
    
    if employee.benefit_method == "FIXED"
        er_pay_dep = employee.category_dep
    else
        er_pay_dep = employee.category_dep * health_invoice_dep
    end
end

# #  ee_deduct_amount
def ee_deduct_amount
    
    # if employee(:subscriber_id).valid?
    #     @ee_deduct_amount = ""
    
         # if employee.employee_category == "NO MATCH"
            if employee.tier == "SUB" or employee.tier == "SPS" or employee.tier == "CH1" or employee.tier == "SPS1"
                ee_deduct_amount = Payroll_deduction.where(pay_sub_id: employee.sub_id).sum(:deduction_amount) 
                # pay_sub_id ?  How to lookup in above call?
            else
                ee_deduct_amount = "N/A-DEPENDENT"
            end
            
        # else 
            
        #     ee_deduct_amount = "NO MATCH"
end

#  ee_deduct_converted payroll.number from csv import
def ee_deduction_converted
        if payroll.number == 1 or payroll.number == 2 && Company.pay_frequency == "Monthly" or Company.pay_frequency == "Semi-Monthly"
             ee_deduction_converted = ee_deduct_amount
             
            elseif payroll.number == 2 && Company.pay_frequency == "Bi-Weekly"
             ee_deduction_converted = ee_deduct_amount / 2 * 26 / 12
             
            elseif payroll.number == 3 && Company.pay_frequency == "Bi-Weekly"
             ee_deduction_converted = ee_deduct_amount / 3 * 26 / 12
             
            elseif payroll.number == 4 && Company.pay_frequency == "Weekly"
             ee_deduction_converted = ee_deduct_amount / 4 * 52 / 12
             
            elseif payroll.number == 5 && Company.pay_frequency == "Weekly"
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
        # if employee.employee_tier != "DEP"
        @total_co_amount = (ee_deduction_converted + er_pay_sub + er_pay_dep)
        # else
        #     if employee.employee_tier == "DEP"
        #         total_co_amount = "0"  #what about company pay of dep?
        #     else
        #         total_co_amount = "NO MATCH"
        #     end
        # end
end

# # Difference of total company amount and health invoice amount
def difference
        difference = Health_invoice.total_charges - total_co_amount  
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
