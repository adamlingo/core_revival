# Core

[![Code Climate](https://codeclimate.com/repos/576c5b1cb43e07008d001e28/badges/c72d3ca9182ffcfc94b2/gpa.svg)](https://codeclimate.com/repos/576c5b1cb43e07008d001e28/feed)

## Requirements

- Ruby
- Rails
- postgres
    - postgresapp is highly recommended: http://postgresapp.com/ (Mac only)

## Quick start

### Clone it

Clone the repo and `bundle install` the gems.

```
git clone https://github.com/CoreEmployeeSolutions/core_redux.git
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

----

### Production and Stage
The app lives at:
prod:  * updating live site link soon!
stage: * TBD on implementation date.

### Hosting
The app is hosted at heroku.
DNS is hosted at Godaddy

### Dev Flow
Read more about the dev flow: https://github.com/CoreEmployeeSolutions/core/wiki/Dev-Flow

### Deployments
Read more about deployments: https://github.com/CoreEmployeeSolutions/core/wiki/Deployments

### Jobs
Read more about scheduled jobs here: https://github.com/CoreEmployeeSolutions/core/wiki/Scheduled-Jobs
