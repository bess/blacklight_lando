# frozen_string_literal: true

require "rails/generators"
module BlacklightLando
  # Generator for adding lando to a blacklight application
  class RunSolr < Rails::Generators::Base
    source_root ::File.expand_path("templates", __dir__)

    # rubocop:disable Naming/HeredocDelimiterNaming
    desc <<-EOF
      This generator makes the following changes to your application:
        1. Adds .lando.yml to your application
        2. Adds lando_env.rb to your application and includes it in application.rb
        3. Copies lando-configured config/blacklight.yml into your application
        4. Copies lando-configured config/database.yml into your application
    EOF
    # rubocop:enable Naming/HeredocDelimiterNaming

    # Add postgres gem to Gemfile
    def add_pg_gem
      gem "pg"
    end

    def bundle_install
      return if Rails.env.test?

      inside destination_root do
        Bundler.with_unbundled_env do
          run "bundle install"
        end
      end
    end

    def create_lando_config
      copy_file ".lando.yml"
      copy_file "lando_env.rb", "config/initializers/lando_env.rb"
      copy_file "blacklight.yml", "config/blacklight.yml"
      copy_file "database.yml", "config/database.yml"
    end
  end
end
