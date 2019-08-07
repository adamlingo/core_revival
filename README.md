# Core

## Integrations & Code Quality
[![Codeship Status for adamlingo/core_revival](https://app.codeship.com/projects/0a613800-9b56-0137-ed11-763e4514bc3d/status?branch=master)](https://app.codeship.com/projects/358484/)
<a href="https://codeclimate.com/repos/576c5b1cb43e07008d001e28/feed"><img src="https://codeclimate.com/repos/576c5b1cb43e07008d001e28/badges/c72d3ca9182ffcfc94b2/issue_count.svg" /></a>

## Requirements

- Ruby
- Rails
- postgres
    - postgresapp is highly recommended: http://postgresapp.com/ (Mac only)

## Quick start

### Clone it

Clone the repo and `bundle install` the gems.

```
git clone https://github.com/adamlingo/core_revival.git
cd core_redux
bundle install
```

### Update database config

Next, create a database config from the example:
```
cp config/database.example.yml config/database.yml
```

You'll want to update the username section:
 ` username: yournamehere `

Now we can setup our database:
```
rake db:create
rake db:migrate
```

### Run it

Launch the app in Rails.

```
rails s
```

Behold! The app is running: http://locahost:3000/


## Testing
This app uses minitest for testing. Run the tests with the following command:
``` rake test ```
* @ryoe wrote tests into Rspec for greater functionality and can be run with:
``` rspec ```

----

### Production
The app is live at:
https://core-revival.herokuapp.com

### Hosting
The app is hosted at heroku.

### Custom Rake
Read more about copying the production db: https://github.com/CoreEmployeeSolutions/core_redux/wiki/Heroku-Restore

### Jobs
Read more about scheduled jobs here: https://github.com/CoreEmployeeSolutions/core_redux/wiki/
