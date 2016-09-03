namespace :api_pto_call do
        
        desc "Timeworx API call for PTO balance per employee"
        
        task get_pto_data:  :environment do
            Company.all.each { |company|
                timework = Timework.where(company_id: company.id).first
                if timework.present?
                    session_id = Timework.createSession(timework.user_id, timework.password)
                    api_url = 'https://www.payrollservers.us'
                    request_url = "#{api_url}/GetActivityFile?sessionID=#{session_id}&BeginDate=string&EndDate=string&FormatName=swipeclockpt&OptionalLaborMapping='"
                    uri = URI.parse(request_url)
                    req = Net::HTTP::Get.new(uri)
                    res = Net::HTTP.start(uri.host, uri.port) {|http|
                        http.request(req)
                    }
                    puts res.body
                else puts "I don't have a timework login for this company."
                end
            }
            #   #save pto data to employee record
            # Employees.all.each { |employee|
            
              
                
                end
          
                
        end
