# BlacklightLando

This gem creates a [Lando](https://lando.dev/) config file for running [Solr](https://solr.apache.org/) in a [Blacklight](https://github.com/projectblacklight/blacklight) application. 

## Pre-requisites: 
1. A [Blacklight](https://github.com/projectblacklight/blacklight) application
2. [Lando](https://lando.dev/)

## Installation
1. Add this gem to the `Gemfile` of your Blacklight application:
   ```
   gem "blacklight_lando", "~> 0.3.0"
   ```
2. Run `bundle install`
3. Run `rails generate blacklight_lando:run_solr`
4. Start lando: `lando start`
5. Start blacklight as normal: `bundle exec rails s`

Your application should now be running against the instance of solr that lando is running in a docker container.

## Usage

To see where solr is running, and connect to the solr console, run `lando info`

To rebuild the docker containers, type `lando rebuild`

To stop the docker containers, type `lando stop`

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests. 

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bess/blacklight_lando. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/bess/blacklight_lando/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the BlacklightLando project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bess/blacklight_lando/blob/main/CODE_OF_CONDUCT.md).
