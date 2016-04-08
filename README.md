# Core

## Running on local:
Get postgres installed: (http://postgresapp.com/)
Next, create a database config from the example:
` cp config/database.example.yml config/database.yml `
You'll want to update the username section: ` username: yournamehere `

Now we can setup our database:
```
rake db:create
rake db:migrate
```
You should be ready to go!

### Testing
This app uses minitest for testing. Run the tests with the following command:
` rake test `

### Production and Stage
The app lives at:
prod:  http://http://coreemployeesolutions.com/
stage: https://core-stage.herokuapp.com/

### Hosting
The app is hosted at heroku.
DNS is hosted at Godaddy

### Dev Flow
Read more about the dev flow: https://github.com/CoreEmployeeSolutions/core/wiki/Dev-Flow

### Deployments
Read more about deployments: https://github.com/CoreEmployeeSolutions/core/wiki/Deployments

### Jobs
Read more about scheduled jobs here: https://github.com/CoreEmployeeSolutions/core/wiki/Scheduled-Jobs
