source 'https://rubygems.org'
ruby '2.3.0'

# DEFAULTS AND POSTGRES
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use postgres as the database for Active Record
gem 'pg'
# Gem for using protected attributes (mass assignment security)
# to gain access to attr_protected and attr_accessible in Models
gem 'protected_attributes'

# JAVASCRIPT
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# CSS
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# bootstrap
gem 'bootstrap-sass'
# scss conversion helper for deployment
gem 'font-awesome-sass'
gem 'font_assets'

# LOGIN/AUTH
gem 'devise' # UI tools for client-user login

# SERVICES/INTEGRATIONS
# Codeship required gem:
gem 'nokogiri' # xlm/html parser
gem 'zendesk_api'
gem 'slack-notifier', require: false

# API LAYER
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# ADMIN UI
gem 'activeadmin', github: 'activeadmin'

# ERROR MONITORING
gem 'sentry-raven'

# Mailgun gems
gem 'rest-client'

gem 'mailgun-ruby'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # debugging with Rails Panel (Chrome-dev-tools)
  gem 'meta_request'
  # db map, run with "rake erd"
  gem 'rails-erd' # generate ERD diagram of db - needs brew install graphviz 
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Optional/better debugging tool (kill byebug later)
  gem 'pry'
  # Automated mini-tests
  gem 'minitest-rails'
  gem 'minitest-reporters'
  # CodeClimate score
  gem 'codeclimate-test-reporter', require: nil
  gem 'dotenv-rails'  # env variables to function like heroku
end

group :production do 
  # Unicorn handles Procfile w/Heroku
  gem 'unicorn'
  gem 'unicorn-worker-killer'
  # This gem enables platform features (heroku)
  gem 'rails_12factor'
end

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

