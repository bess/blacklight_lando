# frozen_string_literal: true

require "rails/generators"
module BlacklightLando
  # Generator for adding lando to a blacklight application
  class LandoGenerator < Rails::Generators::Base
    source_root ::File.expand_path("templates", __dir__)

    # rubocop:disable Naming/HeredocDelimiterNaming
    desc <<-EOF
      This generator makes the following changes to your application:
        1. Adds .lando.yml to your application
        2. Adds lando_env.rb to your application and includes it in application.rb
        3. Copies lando-configured config/blacklight.yml into your application
        4. Adds rsolr to your Gemfile
    EOF
    # rubocop:enable Naming/HeredocDelimiterNaming

    def create_lando_config
      copy_file ".lando.yml"
      copy_file "lando_env.rb", "config/lando_env.rb"
      # gsub_file 'config/application.rb', /require \"rails/all\"/, 'require "rails/all"\nrequire_relative "lando_env"'
    end
  end
end
