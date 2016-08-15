class CompanyPayrollDate < ActiveRecord::Base
  belongs_to :company
  
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
      
     @date = start_date
     
     num_periods.times do |n|
     
        n = Date.new(date) << -1
        
        n.save
  
      
    end

    def self.generate_semi_monthly(company_id, start_date, num_periods, pay_frequency)
      puts 'generate semi-monthly payroll dates'
      # do the work...
    end

    def self.generate_weekly(company_id, start_date, num_periods, pay_frequency)
      puts 'generate weekly payroll dates'
      # do the work...
    end

    def self.generate_bi_weekly(company_id, start_date, num_periods, pay_frequency)
      puts 'generate bi-weekly payroll dates'
      # do the work...
    end
end
