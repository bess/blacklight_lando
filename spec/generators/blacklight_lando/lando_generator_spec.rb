# frozen_string_literal: true

require "spec_helper"
require "generators/lando_generator"
require "fileutils"

TMP_FILE = File.expand_path("../tmp", __dir__)

RSpec.describe BlacklightLando::LandoGenerator, type: :generator do
  destination TMP_FILE
  before do
    FileUtils.rm_rf(TMP_FILE)
    prepare_destination
  end

  it "makes expected files" do # rubocop:disable RSpec/ExampleLength
    run_generator
    expect(destination_root).to have_structure {
      directory "config/initializers" do
        file "lando_env.rb"
      end
      directory "config" do
        file "blacklight.yml"
        file "database.yml"
      end
      file ".lando.yml"
    }
  end

  context "when setting environment variables" do
    let(:env) { double("env") } # rubocop:disable RSpec/VerifiedDoubles
    let(:lando_info) { File.read(File.join(BlacklightLando.root, "spec/fixtures/lando_info.json")) }

    before do
      allow(Rails).to receive(:env).and_return(env)
      allow(env).to receive(:development?).and_return(true)
      # Lando is not installed in CI, so stub any backtick calls
      allow_any_instance_of(Object).to receive(:`).and_return(lando_info) # rubocop:disable RSpec/AnyInstance
    end

    it "sets expected environment variables" do # rubocop:disable RSpec/ExampleLength,RSpec/MultipleExpectations
      require File.expand_path("../../../lib/generators/templates/lando_env.rb", __dir__)
      expect(ENV["lando_test_solr"]).to match(/blacklight-core-test/)
      expect(ENV["lando_development_solr"]).to match(/blacklight-core-dev/)
      expect(ENV["lando_database_creds_database"]).to eq("database")
      expect(ENV["lando_database_creds_username"]).to eq nil
      expect(ENV["lando_database_creds_password"]).to eq ""
    end
  end
end
