namespace :api_pto_call do
        
        desc "Timeworx API call for PTO balance per employee"
        
        # task get_pto_data:  :environment do
        #     Company.all.each { |company|
        #         timework = Timework.where(company_id: company.id).first
        #         if timework.present?
        #             session_id = Timework.createSession(timework.user_id, timework.password)
        #             api_url = 'https://www.payrollservers.us/pg/api12.asmx'
        #             request_url = "#{api_url}/GetActivityFile?sessionID=#{session_id}&BeginDate=2016-1-1&EndDate=2016-8-31&FormatName=swipeclockpt&OptionalLaborMapping=''"
        #             uri = URI.parse(request_url)
        #             req = Net::HTTP::Get.new(uri)
        #             res = Net::HTTP.start(uri.host, uri.port) {|http|
        #                 http.request(req)
        #             }
        #             puts res.body
        #         else puts "#{company.name}I don't have a timework login for this company."
        #         end
        #     }
            #   #save pto data to employee record
            # Employees.all.each { |employee|
            
        task get_pto_data: :environment do
            session_id = Timework.createSession('fiducialok','Thunder2016')
            puts session_id
            api_url = 'https://www.payrollservers.us/pg/api12.asmx'
            request_url = "#{api_url}/GetActivityFile?sessionID=#{session_id}&BeginDate=2016-8-14&EndDate=2016-8-27&FormatName=swipeclockpt&OptionalLaborMapping=''"
                uri = URI.parse(request_url)
                req = Net::HTTP::Get.new(uri)
                res = Net::HTTP.start(uri.host, uri.port) {|http|
                        http.request(req)
                }
                puts res.body
        end
            
        
end
    


              
                
