require 'json'

namespace :swipeclock do

  desc 'swipeclock API things...'

  task auth_test:  :environment do
    response = Swipeclock.authenticate
    puts "response.code: #{response.code}"
    puts "response.body: #{response.body}"

    response_hash = JSON.parse(response.body)
    token = response_hash['token']

    puts "\n -- presenting the auth token -- \n"
    puts token
  end
            
end
    


              
                
