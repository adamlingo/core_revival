require 'json'

namespace :swipeclock do

  desc 'swipeclock API things...'

  task test:  :environment do
    Swipeclock.clock_in
  end
            
end
    


              
                
