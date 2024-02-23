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
    run_generator
  end

  it "makes expected files" do # rubocop:disable RSpec/ExampleLength
    expect(destination_root).to have_structure {
      directory "config" do
        file "lando_env.rb"
      end
      file ".lando.yml"
    }
  end
end
