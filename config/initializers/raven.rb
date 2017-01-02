require 'raven'

Raven.configure do |config|
  config.dsn = ENV["SENTRY_DSN"]
  config.environments = ['production']

  # Work-around to debug errors sent when env reads as default instead of development
  config.current_environment = Rails.env
end
