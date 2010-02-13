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

  def stdout(&block)
    EncoderTools::CLI::Shell.capture(:stdout, &block)
  end

  def stdin(string, &block)
    EncoderTools::CLI::Shell.capture(:stdin, string, &block)
  end
end
