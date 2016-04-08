source 'https://rubygems.org'
ruby '2.3.0'

gem 'mime-types', '~> 2.9', require: 'mime/types/columnar' # fix memory issue with mimetypes
gem 'rails', '~> 4.1.14'

# data
gem 'pg'
gem 'activerecord-import' # active record tools
gem 'upsert'

gem 'haml' # replace HTML with haml

# javascript
gem 'uglifier', '>= 1.3.0' # compressor
gem 'coffee-rails', '~> 4.0.0'
# gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'momentjs-rails', '>= 2.8.1'

# css
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass'
gem 'bootstrap3-datetimepicker-rails', '~> 3.1.3'
gem 'jasny_bootstrap_extension_rails'
gem 'best_in_place' # RESTful unobtrusive jquery inplace editor
gem 'font-awesome-sass'
gem 'kaminari' # paginate views
gem 'bootstrap-kaminari-views' # Paginate kaminari with bootstrap views
gem 'font_assets'

gem 'carmen-rails' # country and state selector?
gem 'humanize' # Humanize numbers

# auth
gem 'devise'
gem 'devise_invitable', '~> 1.3.4'
gem 'cancancan'

# photo uploads
gem 'carrierwave'
gem 'fog'
gem 'mini_magick'

# services/integration
gem 'zendesk_api'
gem 'savon'  # SOAP integration
gem 'nokogiri' # xlm/html parser
gem 'spreadsheet' # read and write spreadsheet docs
gem 'slack-notifier', require: false

# API layer
gem 'jbuilder', '~> 2.0'
gem 'rack-cors', :require => 'rack/cors'

# Generate pdf from html
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# Generic Admin interface
gem 'activeadmin', github: 'activeadmin'

# exception and monitoring
gem 'sentry-raven'

group :development do
  gem 'letter_opener'
  gem 'spring'

  gem 'better_errors'  # debugging
  gem 'binding_of_caller' # debugging
  gem 'meta_request' # debugging with Rails Panel
  gem 'foreman'
  # db related
  gem 'rails-erd' # generate ERD diagram of db - needs brew install graphviz
  gem 'bullet' # orm profiling
  gem 'lol_dba' # find missing indexes
end

# Automated tests with RSpec
group :development, :test do
  gem 'quiet_assets'
  # gem 'rspec-rails', '~> 3.0'
  
  gem 'timecop' # Testing time-dependent actions

  gem 'minitest-rails'
  gem 'minitest-reporters'
  gem 'mocha'

  gem 'pry' # debugging

  gem 'codeclimate-test-reporter', require: nil

  gem 'dotenv-rails'  # env variables to function like heroku
end

group :production do
  gem 'unicorn', '~> 5.0.0'
  gem 'unicorn-worker-killer'
  gem 'rails_12factor'
  gem 'heroku-deflater'
end

gem 'sdoc', '~> 0.4.0',          group: :doc
