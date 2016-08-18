require 'date'

class PayrollDate
  def self.generate_monthly(company_id, start_date, num_periods)
    puts 'generate monthly payroll dates'
    puts "company_id: #{company_id}; start_date: #{start_date}; num_periods: #{num_periods}"

    # create a real Date from our string start_date
    date = Date.parse(start_date)
    puts "date: #{date}"

    # create a PayrollDate and save?
    # PayrollDate.create!(company_id: company_id,
    # 					date: date,
    # 					period: 1)

    (2..num_periods).each do |period|
      date = date >> 1
      puts "loop date: #{date}"

    # PayrollDate.create!(company_id: company_id,
    # 					date: date,
    # 					period: period)
    end
  end
  
    def self.generate_weekly(company_id, start_date, num_periods)
      puts 'generate weekly payroll dates'
          
        date = Date.parse(start_date)
          
        (2..num_periods).each do |period|
          date = date + 7
          puts "loop date: #{date}"
        end
    end
    
    def self.generate_bi_weekly(company_id, start_date, num_periods)
      puts 'generate bi-weekly payroll dates'
          
       date = Date.parse(start_date)
          
        (2..num_periods).each do |period|
          date = date + 14
          puts "loop date: #{date}"
        end
    end
    
    def self.generate_semi_monthly(company_id, start_date, num_periods)
      puts 'generate semi-monthly payroll dates'
          
        date = Date.parse(start_date)
        
        puts "Input Date: #{date}"
          
        (2..num_periods).each do |period|
          case date.day
          
            when 1
              date = Date.new(date.year,date.month,16)
              puts "loop date: #{date}"
            when 15
              date = Date.new(date.year,date.month,-1)
              puts "loop date: #{date}"
            when 16
              date = Date.new(date.year,date.month + 1,1)
              puts "loop date: #{date}"
            else
              date = Date.new(date.year,date.month + 1, 15)
              puts "loop date: #{date}"
          # how to increment by half month?  Most likely 1st and 16th OR 15th and end of month
          # this would not work if date was other than thsoe four
          end
        end
    end
end

PayrollDate.generate_semi_monthly(1, '2016-8-15', 5)

PayrollDate.generate_semi_monthly(2, '2016-8-1', 5)

PayrollDate.generate_semi_monthly(3, '2016-8-16', 5)

PayrollDate.generate_semi_monthly(4, '2016-8-31', 5)

# PayrollDate.generate_bi_weekly(1, '2016-8-15', 5)

# puts "------------------"

# PayrollDate.generate_bi_weekly(2, '2016-8-1', 5)

# puts "------------------"

# PayrollDate.generate_bi_weekly(3, '2016-8-31', 5)


# PayrollDate.generate_monthly(1, '2016-07-01', 3)

# puts "----------------"

# PayrollDate.generate_monthly(2, '2016-08-15', 6)

# puts "----------------"

# PayrollDate.generate_monthly(3, '2016-09-23', 6)