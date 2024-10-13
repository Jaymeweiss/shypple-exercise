# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Setup
This app is configured to be used with Docker using Docker Compose. To run the app, you need to have Docker installed on your machine.

To start the app to take in Stdin inputs, run the following command in the root directory of the app:

```
docker compose run backend bin/rails runner lib/tasks/stdin_processor.rb
```

Clean up after by running:

```
docker compose down --remove-orphans
```

### Running migrations:
Run the following command to run the migrations:

```
docker compose run backend bin/rails db:migrate
```

### Running tests:
Run the following commands to run the tests:

```
docker compose run backend bin/rails db:environment:set RAILS_ENV=test
docker compose run backend bin/rails test
```

### Opening up a Rails console:
Run the following command to open up a Rails console:

```
docker compose run backend bin/rails c
```