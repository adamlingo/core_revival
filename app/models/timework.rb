require 'net/http'

class Timework < ActiveRecord::Base
    belongs_to :company

    def self.build_encoded_uri(timework_id, timework_pass)
        api_url = 'https://www.swipeclock.com/pg/api12.asmx'
        request_url = "#{api_url}/CreateSession"
        query_params = [
            ['login', timework_id],
            ['password', timework_pass],
            ]
        uri = URI.parse(request_url)
        uri.query = URI.encode_www_form(query_params)
        uri
    end
    
    def self.createSession(timework_id, timework_pass)

        uri = build_encoded_uri(timework_id, timework_pass)
        req = Net::HTTP::Get.new(uri.to_s)
        res = Net::HTTP.start(uri.host, uri.port) {|http|
            http.request(req)
        }
        h = Hash.from_xml(res.body)
        h['CreateSessionResult']['SessionID']

    end
end
