class CompanyPayrollDate < ActiveRecord::Base
    
    belongs_to :company
    
    def company_id
        
        company_id = company(:id)
    end
   
   
   def initial_date
       #need to be next period end date
       #initial_date = 
   end
   
   def pay_frequency
       pay_frequency = company(:pay_frequency)
   end
    
   def pay_period 
       
       100.times do |n|
           initial_date
           if pay_frequency == "Monthly"
               pay_period = initial_date
               
           elseif pay_frequency == "Semi-Monthly"
               
           elseif pay_frequency == "Bi-Weekly"
               
           elseif pay_frequency == "Weekly"
               
           #else
          end
        end
   end
   
  # def next inc
  #   self.next_payroll_schedule_date = self.next_payroll_schedule_date + inc.days
  #   self.save
  # end

  # def self.countsD x
  #   inc = 0
  #   divider = 1
  #   if(x == 'Weekly')
  #     divider = 52
  #     inc = 7
  #   elsif(x == 'Semi-Monthly')
  #     divider = 24
  #     inc = 15
  #   elsif(x == 'Bi-Weekly')
  #     divider = 26
  #     inc = 14
  #   elsif(x == 'Monthly')
  #     divider = 12
  #     inc = 30
  #   end

  #   {:divider => divider, :inc => inc}
  # end

    
    
end
