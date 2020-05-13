# Brownfield Of Dreams

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
  * [Schema Design](#schema-design)
* [Getting Started](#getting-started)
  * [Installation](#installation)
  * [Testing](#testing)
  * [Deployment](#deployment)
* [Contributors](#contributors)


## About the Project

Brownfield Of Dreams is a Ruby on Rails brownfield project used to import YouTube videos and playlists for online learning. 

This was a paired project for Turing School of Software & Design Module 3.

* Github API consumption
* GitHub Oauth implementation
* bookmarking of video segments
* functionality to add friends

We also set up Continuous Integration using Travis CI. 

Launch the Heroku [app](https://fp-brownfield.herokuapp.com/)


### Built With:

* Rails 5.2.4.2
* Ruby 2.5.3
* Postgres Database
* Faraday
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)


### Schema Design

![alt text](app/assets/images/schema.png)

## Getting Started

### Installation

First you'll need to setup an API key with YouTube and have it defined within `ENV['YOUTUBE_API_KEY']`. There will be one failing spec if you don't have this set up.

You will also need a GitHub Application `client_id` and `client_secret` and defined them as  `ENV['GITHUB_CLIENT_ID']` and 
  `ENV['GITHUB_CLIENT_SECRET']`.
  
To setup Brownfield Of Dreams locally, run the following commands:
```
$ git clone git@github.com:PaulDebevec/brownfield-of-dreams.git
# OR if using HTTPS - $ git clone https://github.com/PaulDebevec/brownfield-of-dreams.git 
$ cd brownfield-of-dreams
$ bundle install
$ bundle update
$ rails db:{drop,create,migrate,seed}
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```
### Testing

Run the test suite:
```
$ bundle exec rspec
```

### Deployment

Create a new heroku app and connect to your local `BrownFieldOfDreams` repository with:
```
$ heroku git:remote -a your_heroku_app_name
```

Deploy `BrownFieldOfDreams` from Heroku.

The original repository of the `BrownFieldOfDreams` project can be found [here](https://github.com/turingschool-examples/brownfield-of-dreams).

### Versions
* Ruby 2.4.1
* Rails 5.2.0

## Contributors

[Fred Rondina](https://github.com/fredrondina96)

[Paul Debevec](https://github.com/PaulDebevec) 
