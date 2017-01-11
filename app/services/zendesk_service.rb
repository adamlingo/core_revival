require 'zendesk_api'

# use ZendeskService.create_team(user, 'newtiket', 'yay important ticket')
class ZendeskService
  class << self

    def create_ticket(user, subject, comment, priority = 'normal')
      client = set_credentials
      if Rails.env.production?
        ZendeskAPI::Ticket.create!(client, requester: user, subject: subject, comment: { value: comment }, priority: priority)
      end
    end

    private def set_credentials
      ZendeskAPI::Client.new do |config|
        config.url = ENV['ZENDESK_URL'] # e.g. https://mydesk.zendesk.comapi/v2
        config.username = ENV['ZENDESK_USERNAME']
        config.token = ENV['ZENDESK_TOKEN']
        config.password = ENV['ZENDESK_PASSWORD']
        config.retry = true
      end
    end
  end
end

# mock ZendeskService.create_ticket: return(true)
# mock User.create_ticket: return(true)
# mock RandoController.mock.create_ticket: return(true)