# frozen_string_literal: true

require "rails/generators"
module BlacklightLando
  # Generator for adding lando to a blacklight application and
  # configuring it to use Solr
  class RunSolr < Rails::Generators::Base
    source_root ::File.expand_path("templates", __dir__)

    # rubocop:disable Naming/HeredocDelimiterNaming
    desc <<-EOF
      This generator makes the following changes to your application:
        1. Adds .lando.yml to your application
        2. Adds lando_env.rb to your application and includes it in application.rb
        3. Copies lando-configured config/blacklight.yml into your application
    EOF
    # rubocop:enable Naming/HeredocDelimiterNaming

    def create_lando_config
      copy_file ".lando_solr.yml", ".lando.yml"
      copy_file "lando_env.rb", "config/initializers/lando_env.rb"
      copy_file "blacklight.yml", "config/blacklight.yml"
    end
  end
end
