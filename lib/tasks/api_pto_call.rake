require 'csv'

namespace :api_pto_call do
        
        desc "Timeworx API call for PTO balance per employee"
        
        task get_company_pto:  :environment do
            Company.all.each { |company|
                puts "#{company.id}"
                timework = Timework.where(company_id: company.id).first
                if timework.present? && timework.client_id.present?
                    # use the timework record for the username, password, client_id
                    raw_data = Timework.pto_report_by_client(ENV['TIMEWORKS_API_ADMIN_USER'], ENV['TIMEWORKS_API_ADMIN_PASSWORD'] timework.client_id)
                    puts raw_data
                    #parse data
                    CSV.foreach(raw_data, headers: true) do |row|
                        pto_hash = row.to_hash
                        pto_balance = find_or_create_by!(ee_id: pto_hash['EE Code'],
                                                        end_balance: pto_hash['Ending Balance'])
                        pto_balance.save!
                    end
                    
                else
                   puts "Company: #{company.name}, I don't have a timework login for this company."
                end
            }
        end
            
end
    


              
                
