require 'date'

class PayrollDate
  def self.generate_monthly(company_id, start_date, num_periods)
    puts 'generate monthly payroll dates'
    puts "company_id: #{company_id}; start_date: #{start_date}; num_periods: #{num_periods}"

    # create a real Date from our string start_date
    date = Date.parse(start_date)
    puts "date: #{date}"

    # create a PayrollDate and save?
    # PayrollDate.create!(company_id: company_id,date: date,period: 1)

    (2..num_periods).each do |period|
        date = date >> 1
        puts "loop date: #{date}"

    # PayrollDate.create!(company_id: company_id,date: date,period: period)
    end
  end
end


PayrollDate.generate_monthly(1, '2016-07-01', 3)
puts "----------------"

PayrollDate.generate_monthly(2, '2016-08-15', 6)

puts "----------------"

PayrollDate.generate_monthly(3, '2016-09-23', 6)