require 'mailgun'
# Uses MailGun
class Mailer

  def self.send_test
    # First, instantiate the Mailgun Client with your API key
    mg_client = Mailgun::Client.new ENV["MAILGUN_API_KEY"]

    # Define your message parameters
    message_params = {:from    => ENV["MAILGUN_DEFAULT_FROM"],  
                  :to      => 'alingo@myemployeesolution.com',
                  :subject => 'The Ruby SDK is awesome!',
                  :text    => 'It is really easy to send a message!'}

    # Send your message through the client
    mg_client.send_message ENV["MAILGUN_SENDING_DOMAIN"], message_params
  end

end