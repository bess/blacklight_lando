# frozen_string_literal: true

require_relative "blacklight_lando/version"
require_relative "generators/run_solr"
require_relative "generators/run_solr_and_postgresql"

# Configure a Blacklight application to use Lando for Solr and Postresql
module BlacklightLando
  class Error < StandardError; end

  def self.root
    File.dirname __dir__
  end
end
