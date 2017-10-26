namespace :dbmaint do
  desc "vacuum the db"
  task vacuum: :environment do
    if Time.now.to_date.strftime('%A') == 'Sunday'
      ActiveRecord::Base.connection.execute 'vacuum analyze;'
    end
  end

  desc "Backs up heroku database and restores it locally."
  task import_from_heroku: :environment do
    HEROKU_APP_NAME = 'core-redux' # Change this if app name is not picked up by `heroku` git remote.
    # c = Rails.configuration.database_configuration[Rails.env]
    heroku_app_flag = HEROKU_APP_NAME ? " --app #{HEROKU_APP_NAME}" : nil
    Bundler.with_clean_env do
      puts "[1/5] make sure you have run: 'createdb core_redux_dev'"
      puts "[2/5] Capturing backup on Heroku"
      `heroku pg:backups capture DATABASE_URL#{heroku_app_flag}`
      puts "[3/5] Downloading backup onto disk"
      `curl -o tmp/latest.dump \`heroku pg:backups public-url #{heroku_app_flag} | cat\``
      puts "[4/5] Mounting backup on local database"
      `pg_restore --clean --verbose --no-acl --no-owner -h localhost -d core_redux_dev tmp/latest.dump`
      puts "[5/5] Removing local backup"
      `rm tmp/latest.dump`
      puts "Celebrate!"
    end
  end
end
