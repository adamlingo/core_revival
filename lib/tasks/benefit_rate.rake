namespace :benefit_rate do
  task import: :environment do
    file_path = "#{Rails.root}/test/fixtures/BCBS_G712PFR.csv".freeze

    benefit_detail_id = BenefitDetail.last.id
    BenefitRate.import(benefit_detail_id, file_path)
  end
end
