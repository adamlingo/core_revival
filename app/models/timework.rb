require 'net/http'

class Timework < ActiveRecord::Base
    belongs_to :company

    def self.build_encoded_uri(user_id, password)
        api_url = 'http://www.swipeclock.com/pg/api12.asmx'
        request_url = "#{api_url}/CreateSessionSelectClient"
        query_params = [
            ['login', user_id],
            ['password', password],
            ['secondFactor', ''],
            ['matchfield', 'ClientName'],
            ['ClientID', 'MMW']
            ]
        uri = URI.parse(request_url)
        uri.query = URI.encode_www_form(query_params)
        uri
    end
    
    
    def self.pto_report
        
        session_id = Timework.createSession('fiducialok','Thunder2016')
            puts session_id
            api_url = 'https://www.payrollservers.us/pg/api12.asmx'
            request_url = "#{api_url}/GetActivityFile?sessionID=#{session_id}"
            query_params = [
                ['BeginDate', '2016-8-14'],
                ['EndDate', '2016-8-27'],
                ['FormatName', 'swipeclockpto'],
                ['OptionalLaborMapping','']
                ]
                uri = URI.parse(request_url)
                uri.query = URI.encode_www_form(query_params)
                uri
                req = Net::HTTP::Get.new(uri)
                res = Net::HTTP.start(uri.host, uri.port) {|http|
                        http.request(req)
                }
    end
            
    def self.createSession(user_id, password)

        uri = build_encoded_uri(user_id, password)
        req = Net::HTTP::Get.new(uri.to_s)
        res = Net::HTTP.start(uri.host, uri.port) {|http|
            http.request(req)
        }
        h = Hash.from_xml(res.body)
        h['CreateSessionResult']['SessionID']
       
    end
end
