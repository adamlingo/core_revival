require 'jwt'
require 'net/http'
require 'uri'

class Swipeclock < ActiveRecord::Base
    

# create originating token
    def self.sso #(employee)
    
        # header = {
        #   'typ' => 'JWT',
        #   'alg' => 'HS256'
        # }

        t = Time.now + 60
      
        # emp_id = EmployeeAdditionalLogin.find_by(employee_id: employee.id)
        payload = {
          'iss' => 539,
          'exp' => t.to_i,
          'user' => {
            'type' => 'empcode',
            'id' => '0156'
          },
          'site' => 53466,
          'iat' => t.to_i,
          'product' => 'twpemp'          
        }
          
        puts "payload: #{payload}"
        hmac_secret = 'XMhgNMqD550tqqDhj1Ic5cDvghhQbjNaUd1xdwQ1CXNDspCmf2ljIpNneGfHfzOz'
        
        token = JWT.encode payload, hmac_secret, 'HS256'
                
        puts "token: #{token}"
        
        decoded_token = JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
       
        puts "decoded_token: #{decoded_token}"
    end


# # call authentication service

    # API_URL = "https://clock.payrollservers.us/AuthenticationService/oauth2".freeze

  def self.authenticate
    
    token = sso
    http = Net::HTTP.new("https://clock.payrollservers.us/AuthenticationService/oauth2/usertoken")
    
    request = Net::HTTP::Post.new("/#{token}")
    response = http.request(request)

    # request_url = "#{API_URL}/#{token}"
    # uri = URI.parse(request_url)
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    # req = Net::HTTP::Post.new(uri)
    # res = http.request(req)
    
    # puts res
  end


# # return token
end

