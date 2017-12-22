require "bundler/setup"
require "encoder-tools"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def subtitle(range, text)
    EncoderTools::Subtitles::Subtitle.new(range, text)
  end

  def subfile(name)
    File.read(subfile_path(name))
  end

  def subfile_path(name)
    fixture_path("subtitles/#{name}.srt")
  end

  def textfile(name)
    File.read(textfile_path(name))
  end

  def textfile_path(name)
    fixture_path("textfile/#{name}.txt")
  end
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  def fixture(name)
    File.read(fixture_path(name))
  end

  def fixture_path(name)
    File.expand_path("../fixtures/#{name}", __FILE__)
  end
end

RSpec.shared_context 'a CLI command' do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:options) { {:input => input, :output => output} }
  let(:shell) { double('EncoderTools::CLI') }
  subject { described_class.new(shell, options) }
end
