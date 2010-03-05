$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'encoder-tools'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
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

  def fixture(name)
    File.read(fixture_path(name))
  end

  def fixture_path(name)
    File.expand_path("../fixtures/#{name}", __FILE__)
  end

  shared_examples_for 'a CLI command' do
    attr_reader :input, :output, :options, :shell

    before do
      @input  = StringIO.new
      @output = StringIO.new
      @options = {:input => @input, :output => @output}
    end

    def stub_shell!
      @shell = stub('shell')
    end

    subject { described_class.new(@shell, @options) }
  end
end
