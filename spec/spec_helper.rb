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
    File.read(File.dirname(__FILE__) + "/fixtures/subtitles/#{name}.srt")
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
