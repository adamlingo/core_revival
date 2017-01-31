namespace :payroll_record do
  
  task csv: :environment do
  	csv = PayrollRecord.to_csv
  	puts csv
  end
  

end
