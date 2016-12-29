require 'jwt'

class SSO < ActiveRecord::Base
    

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

# POST https://clock.payrollservers.us/AuthenticationService/oauth2/usertoken

# # return token
end

