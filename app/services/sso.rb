require 'jwt'

# create originating token


# Swipeclock API Key aka secret
XMhgNMqD550tqqDhj1Ic5cDvghhQbjNaUd1xdwQ1CXNDspCmf2ljIpNneGfHfzOz


# accountant id
accountant id 539

#unix timestamp
Time.now.to_i

#product type
"TWPemp"



# call authentication service

POST https://clock.payrollservers.us/AuthenticationService/oauth2/usertoken

