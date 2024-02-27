# frozen_string_literal: true

require_relative "blacklight_lando/version"
require_relative "generators/lando_generator"

module BlacklightLando
  class Error < StandardError; end

  def self.root
    File.dirname __dir__
  end
end
