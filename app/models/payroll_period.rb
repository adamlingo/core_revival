class PayrollPeriod < ActiveRecord::Base
  belongs_to :company
  require 'date'

  # Creates static payroll period period given an initial date and a set pay frequency for 
  # a company
  def self.generate_payroll_dates(company_id, pay_frequency, start_date, num_periods, date_format)
    date = Date.strptime(start_date, date_format)
    num_periods += 1

    case pay_frequency
      when 'monthly'
        generate_monthly(company_id, date, num_periods)
      when 'semi-monthly'
        generate_semi_monthly(company_id, date, num_periods)
      when 'weekly'
        generate_weekly(company_id, date, num_periods)
      when 'bi-weekly'
        generate_bi_weekly(company_id, date, num_periods)
      else
        raise StandardError.new "OMG! OMG! OMG! '#{pay_frequency}' is not a valid payroll type"
    end
  end

  def to_s
    "year: #{year}, month: #{month}, day: #{day}, pay period; #{pay_period}"
  end

  private
   
    def self.generate_monthly(company_id, date, num_periods)

      (1...num_periods).each do |period|
        date = date >> 1        

        PayrollPeriod.create!(company_id: company_id,
                              year: date.year, 
                              month: date.month,
                              day: date.day,
                              pay_period: 'monthly')
      end
    end

    def self.generate_semi_monthly(company_id, date, num_periods)

      (1...num_periods).each do |period|
        case date.day
          when 1
            date += 15.days
          when 15
            date = Date.new(date.year, date.month, -1)
          when 16
            date = Date.new(date.year, date.month, -1)
            date += 1.days
          when Date.new(date.year, date.month, -1).day
            date = Date.new(date.year, date.month, -1)
            date += 15.days
          else
            raise StandardError.new "OMG! OMG! OMG! '#{date}' is not a valid date for semi-monthly payroll"
        end

        PayrollPeriod.create!(company_id: company_id,
                              year: date.year, 
                              month: date.month,
                              day: date.day,
                              pay_period: 'semi-monthly')
      end
    end
    
    def self.generate_weekly(company_id, date, num_periods)

      (1...num_periods).each do |period|
        date += 1.weeks

        PayrollPeriod.create!(company_id: company_id,
                              year: date.year, 
                              month: date.month,
                              day: date.day,
                              pay_period: 'weekly')
      end
    end
    
    def self.generate_bi_weekly(company_id, date, num_periods)

      (1...num_periods).each do |period|
        date += 2.weeks

        PayrollPeriod.create!(company_id: company_id,
                              year: date.year, 
                              month: date.month,
                              day: date.day,
                              pay_period: 'bi-weekly')
        end
    end
end
  