require 'net/http'

class Timework < ActiveRecord::Base
    belongs_to :company

    def self.build_encoded_uri(user_id, password)
        api_url = 'http://www.payrollservers.us/pg/api12.asmx'
        request_url = "#{api_url}/CreateSessionSelectClient"
        query_params = [
            ['login', user_id],
            ['password', password],
            ['secondFactor', ''],
            ['matchfield', 'ClientName'],
            ['clientID', 'MMW']
            ]
        uri = URI.parse(request_url)
        uri.query = URI.encode_www_form(query_params)
        uri
    end
    
    def self.createSession(user_id, password)

        uri = build_encoded_uri(user_id, password)
        req = Net::HTTP::Get.new(uri.to_s)
        res = Net::HTTP.start(uri.host, uri.port) {|http|
            http.request(req)
        }
        h = Hash.from_xml(res.body)
        h['CreateSessionResult']['SessionID']
        puts h
    end
end
