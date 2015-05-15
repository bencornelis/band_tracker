# Bands and Venues

##Date

## Author
Ben Cornelis

## About

Sinatra app using Active Record (Ruby v 2.2.0) with the following features:

- users can add, delete, update, and view bands and venues
- users can assign multiple bands to venues and venues to bands
- users can search for the best venue for a specific genre of music

## Installation

Retrieve the included Gemfile and Run the following command
```
bundle install
```

## Usage

#### Database setup

Run the following commands:

- rake db:create
- rake db:migrate
- rake db:test:prepare

#### Run the app

To use the app run:
```
ruby app.rb
```
Navigate in your browser to localhost:4567.

### Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as
possible to help us fixing the possible bug. We also encourage you to help even more by forking and
sending us a pull request.

## License

MIT License. Copyright 2015
