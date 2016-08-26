class Timework < ActiveRecord::Base
    belongs_to :company
    
    def initialize
        @user_id = 
        @password = 
    end 
    
    def self.createSession(user_id, password)
    initialize
    
    require 'net/http'
    request_url = 'http://www.swipeclock.com/pg/api12.asmx/CreateSession?login='+user_id+'&password='+password+'&secondFactor= '
    url = URI.parse(request_url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    h = Hash.from_xml(res.body)
    sesID = h['CreateSessionResult']['SessionID']
    return sesID
    end
end
