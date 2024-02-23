# frozen_string_literal: true

require_relative "lib/blacklight_lando/version"

Gem::Specification.new do |spec|
  spec.name = "blacklight_lando"
  spec.version = BlacklightLando::VERSION
  spec.authors = ["Bess Sadler"]
  spec.email = ["bess.sadler@princeton.edu"]

  spec.summary = "Configure a blacklight application to use lando for local development"
  spec.description = "Configure a blacklight application to use lando for local
    development. Lando will spin up a docker container with two instances of solr,
    one for development and one for testing."
  spec.homepage = "https://github.com/bess/blacklight_lando"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bess/blacklight_lando"
  spec.metadata["changelog_uri"] = "https://github.com/bess/blacklight_lando/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "blacklight", ">= 7.0"

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "generator_spec"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop-rspec"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
