require 'thor'

module EncoderTools
  class CLI < Thor
    autoload :Subtitles, 'encoder-tools/cli/subtitles'

    desc "renumber [--input FILE] [--output FILE]", "Renumber badly-numbered SRT subtitle text"
    method_option :input,  :type => :string, :required => false
    method_option :output, :type => :string, :required => false
    def renumber
      CLI::Subtitles::Renumber.run(self, options)
    end
  end
end
