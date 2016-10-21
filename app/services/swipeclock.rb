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
        
        # decoded_token = JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
       
        # puts "decoded_token: #{decoded_token}"

        token
    end


# # call authentication service

    # API_URL = "https://clock.payrollservers.us/AuthenticationService/oauth2".freeze

  def self.authenticate
    
    originating_token = sso
    
    puts "\n-- request originating_token from AuthorizationService --\n"
    request_url = "https://clock.payrollservers.us/AuthenticationService/oauth2/usertoken"
    uri = URI.parse(request_url)
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    # we need to figure out how to do without VERIFY_NONE
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE     

    req = Net::HTTP::Post.new(uri)

    req['Authorization'] = "Bearer #{originating_token}"
    req['Content-type'] = 'application/json'
    res = http.request(req)
  
    puts "res.body: #{res.body}"

    response_hash = JSON.parse(res.body)

    puts "response_hash: #{response_hash}"
    token = response_hash['token']

    puts "\n -- presenting the auth token -- \n"
    puts token
    token
  end

  def self.clock_in
    token = self.authenticate
    # do stuff..
  end


# # return token
end

