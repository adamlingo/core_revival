require 'jwt'
require 'net/http'
require 'uri'

class Swipeclock < ActiveRecord::Base
    
    
    def ee_id_clock_in
      EmployeeAdditionalLogin.find_by(employee_id: current_user.id)
    end
      

# create originating token
    def self.sso(employee_id)
    
        ee = EmployeeAdditionalLogin.find_by(employee_id: employee_id)
        if ee.nil?
          return nil
        end
        
        ee_id = ee.swipeclock_ee_id
        t = Time.now + 60
        payload = {
          'iss' => ENV['SWIPECLOCK_ACCOUNTANT_ID'],
          'exp' => t.to_i,
          # 'employeeId' => 115521021,
          # 'id' => 115521021,
          'user' => {
            'type' => 'empcode',
            'id' => ee_id
          },
          'site' => ENV['SWIPECLOCK_SITE'],
          'iat' => t.to_i,
          'product' => 'twpemp'          
        }
          
        puts "payload: #{payload}"
        hmac_secret = ENV['SWIPECLOCK_SECRET_KEY']
        
        token = JWT.encode payload, hmac_secret, 'HS256'
                
        puts "token: #{token}"
        
        # decoded_token = JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
       
        # puts "decoded_token: #{decoded_token}"

        token
    end


# # call authentication service


  def self.authenticate(employee_id)
    
    originating_token = sso(employee_id)
    
    if originating_token.nil?
      return nil
    end
    
    
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


    def self.clock_in(employee_id)
  
      token = self.authenticate(employee_id)
      
      request_url = "https://clock.payrollservers.us/?enclosed=1&compact=1&showess=1&jwt=#{token}"
      uri = URI.parse(request_url)
      
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
  
      # we need to figure out how to do without VERIFY_NONE
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE     
  
      req = Net::HTTP::Get.new(uri)
      req['Content-type'] = 'application/json'
      res = http.request(req)
      
      puts "res.body:: #{res.body}"
    
    end
end

