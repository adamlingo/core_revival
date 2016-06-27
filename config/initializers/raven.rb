require 'raven'

# From old 'core' Sentry set-up, minus stage env.
Raven.configure do |config|
  config.dsn = ENV["SENTRY_DSN"]
  config.environments = ['production']
end
