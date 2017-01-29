namespace :payroll_record do
  
  task csv: :environment do
    pr = PayrollRecord.last_name
    pr.to_csv
  end
  

end
