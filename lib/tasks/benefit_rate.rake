namespace :benefit_rate do
  task import: :environment do
    file_path = "#{Rails.root}/test/fixtures/BCBS_G712PFR.csv".freeze

    benefit_detail_id = 4
    BenefitRate.import(benefit_detail_id, file_path)
  end
  
  task compute_rate: :environment do
    
    employee_id = 4
    company_id = 3
    
    BenefitRate.compute_rate(company_id, employee_id)
    
  end
end
