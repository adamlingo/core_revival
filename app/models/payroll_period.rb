class CompanyPayrollDate < ActiveRecord::Base
  belongs_to :company
  require 'date'
  # Creates static payroll period period given an initial date and a set pay frequency for 
  # a company
  def self.generate_payroll_dates(company_id, start_date, num_periods, pay_frequency)
    case pay_frequency
      when 'monthly'
        generate_monthly(company_id, start_date, num_periods)
      when 'semi-monthly'
        generate_semi_monthly(company_id, start_date, num_periods)
      when 'weekly'
        generate_weekly(company_id, start_date, num_periods)
      when 'bi-weekly'
        generate_bi_weekly(company_id, start_date, num_periods)
      else
        raise StandardError.new "OMG! OMG! OMG! '#{pay_frequency}' is not a valid payroll type"
    end
  end



  private
   
    def self.generate_monthly(company_id, start_date, num_periods)
      puts 'generate monthly payroll dates'
      puts "company_id: #{company_id}; start_date: #{start_date}; num_periods: #{num_periods}"
    
      # create a real Date from our string start_date
    
       date = Date.parse(start_date)  # is there a refactor that would keep from repeating?
    
          
         (2..num_periods).each do |period|
            date = date >> 1
         end
    end

    def self.generate_semi_monthly(company_id, start_date, num_periods)
      puts 'generate semi-monthly payroll dates'
          
        date = Date.parse(start_date)
          
        (2..num_periods).each do |period|
          case date.day
          
            when 1
              date = Date.new(date.year,date.month,16)
            when 15
              date = Date.new(date.year,date.month,-1)
            when 16
              date = Date.new(date.year,date.month,1)
            else
              date = Date.new(date.year,date.month >> 1, 1)
          # how to increment by half month?  Most likely 1st and 16th OR 15th and end of month
          # this would not work if date was other than thsoe four
          end
        end
    end
    
    def self.generate_weekly(company_id, start_date, num_periods)
      puts 'generate weekly payroll dates'
          
        date = Date.parse(start_date)
          
        (2..num_periods).each do |period|
          date = date + 7
        end
    end
    
    def self.generate_bi_weekly(company_id, start_date, num_periods)
      puts 'generate bi-weekly payroll dates'
          
       date = Date.parse(start_date)
          
        (2..num_periods).each do |period|
          date = date + 14
        end
    end
end
  