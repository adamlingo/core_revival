namespace :api_pto_call do
        
        desc "Timeworx API call for PTO balance per employee"
        
        task get_company_pto:  :environment do
            Company.all.each { |company|
                puts "#{company.id}"
                timework = Timework.where(company_id: company.id).first
                if true || timework.present?
                    # use the timework record for the username, password, client_id
                    raw_data = Timework.pto_report_by_client('fiducialok', 'Thunder2016', Company.client_id)
                    # Employee.save_pto(company.id, raw_data)
                    puts raw_data.body
                else
                   puts "#{company.name}I don't have a timework login for this company."
                end
            }
        end
            
        task get_pto_data: :environment do
            raw_data = Timework.pto_report_by_client('fiducialok','Thunder2016', 'Green Bambino')
            puts "SHOW ME THE DATA!!!"
            puts raw_data
        end
        
end
    


              
                
