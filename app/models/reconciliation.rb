# class Reconciliation < ActiveRecord::Base
# # ee_category

# def employee
#     employee=employee.benefit_detail
# end


# def ee_category

#    employee.employee_category
   
# end



# #  er_pay_amount

# # def er_pay_amount
    
# #     # if employee(:subscriber_id).valid?
# #     #     @er_pay_amount = ""
 
# #         if ee_category.null?
           
# #             if employee.benefit_method == "%"
# #                 er_pay_amount = employee.benefit_amount * ee_invoice_amount
# #             else
# #                 er_pay_amount = employee.er_fixed 
# #                 # need to update when schema is updated for benefit_detail
# #             end
# #         else
# #             er_pay_amount == "NO MATCH"
        
        
# #         end
        
# #     er_pay_amount
    
# # end



    

# #  ee_deduct_amount

# def ee_deduct_amount
    
#     # if employee(:subscriber_id).valid?
#     #     @ee_deduct_amount = ""
    
#         if employee.employee_category == "NO MATCH"
#             if employee.tier == sub or sps or ch1 or sps1
#                 # look up subscriber_id in payroll import and return sum of deductions
#             else
#                 ee_deduct_amount = "N/A-DEPENDENT"
#             end
            
#         else ee_deduct_amount = "NO MATCH"
        
            
#         end
# end


        
    
#  ee_deduct_converted payroll.number from csv import

# def ee_deduction_converted
#         if payroll.number == 1 or 2 && company.pay_frequency == "Monthly" or "Semi-Monthly"
#          ee_deduction_converted = ee_deduct_amount
         
#         else if payroll.number == 2 && company.pay_frequency == "Bi-Weekly"
#          ee_deduction_converted = ee_deduct_amount / 2 * 26 / 12
         
#         else if payroll.number == 3 && company.pay_frequency == "Bi-Weekly"
#          ee_deduction_converted = ee_deduct_amount / 3 * 26 / 12
         
#         else if payroll.number == 4 && company.pay_frequency == "Weekly"
#          ee_deduction_converted = ee_deduct_amount / 4 * 52 / 12
         
#         else if payroll.number == 5 && company.pay_frequency == "Weekly"
#          ee_deduction_converted = ee_deduct_amount / 5 * 52 / 12
         
#         else ee_deduction_converted = ee_deduct_amount
#     end
       
# end
        
        
# #  er_pay

# def er_pay
  
#  if employee.benefit_method == "FIXED"
#      er_pay = employee.benefit_amount
#  else
#      er_pay = employee.benefit_amount * insurance.amount  #need to define variable based upon CSV import
#  end
 
# end
 
# #  total_co_amount
# #  Still need to address situation where er pays portion of dependent coverage

# def total_co_amount
    
#     # if employee(:subscriber_id).valid?
#     #     @total_co_amount = ""
#     # else
#         if employee.employee_tier != "DEP"
#             total_co_amount = (ee_deduction_converted + er_pay)
#         else
#             if employee.employee_tier == "DEP"
#                 total_co_amount = "0"  #what about company pay of dep?
#             else
#                 total_co_amount = "NO MATCH"
#             end
#         end
    
# end

# # Difference

# def difference
    
#     difference = insurance.amount - total_co_amount  #need insurance.amount updated with csv reference
    
#     puts difference
# end

# end

            




        
