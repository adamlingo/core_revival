namespace :benefit_rate do
  task import: :environment do
    file_path = "#{Rails.root}/test/fixtures/BCBS_G712PFR.csv".freeze

    benefit_detail_id = 10
    BenefitRate.import(benefit_detail_id, file_path)
  end
  
  task compute_rate: :environment do
    
    employee_id = 4
    effective_date = Date.parse("2017-02-01")
    benefit_detail_id = 10
    
    BenefitRate.compute_rate(employee_id, benefit_detail_id, effective_date)
    
  end
end
