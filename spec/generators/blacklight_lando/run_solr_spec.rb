# frozen_string_literal: true

require "spec_helper"
require "generators/run_solr"
require "fileutils"

TMP_DIR = File.expand_path("../tmp", __dir__)

RSpec.describe BlacklightLando::RunSolr, type: :generator do
  destination TMP_DIR
  let(:pristine_gemfile) { File.join(BlacklightLando.root, "spec/fixtures/Gemfile") }
  let(:env) { double("env") } # rubocop:disable RSpec/VerifiedDoubles

  before do
    FileUtils.rm_rf(TMP_DIR)
    prepare_destination
    FileUtils.cp(pristine_gemfile, File.join(TMP_DIR, "Gemfile"))
    allow(Rails).to receive(:env).and_return(env)
    allow(env).to receive(:development?).and_return(true)
    allow(env).to receive(:test?).and_return(true)
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

  context "when requiring new gems" do
    it "adds them to the Gemfile" do # rubocop:disable RSpec/MultipleExpectations
      expect(File.read(File.join(TMP_DIR, "Gemfile"))).not_to match(/gem .pg./)
      run_generator
      expect(File.read(File.join(TMP_DIR, "Gemfile"))).to match(/gem .pg./)
    end
  end

  context "when setting environment variables" do
    let(:lando_info) { File.read(File.join(BlacklightLando.root, "spec/fixtures/lando_info.json")) }

    before do
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
