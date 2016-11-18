require 'slack-notifier'

class SlackService

  def self.notify(channel, message)
    slack_message = "[#{Rails.env.capitalize}] #{message}"
    notifier = get_notifier(channel)
    notifier.ping Slack::Notifier::LinkFormatter.format(slack_message)
  end

  private

    def self.get_notifier(channel)
      assert_slack_url_set ENV["SLACK_URL"]
      Slack::Notifier.new ENV["SLACK_URL"], channel: channel, username: 'mighty-api-notifier'
    end

    def self.assert_slack_url_set(url)
      if url.to_s.length == 0
        #if SLACK_URL is not set, we cannot instantiate the notifier due to invalid Uri
        raise "Environment variable SLACK_URL must be set!"
      end
    end
end