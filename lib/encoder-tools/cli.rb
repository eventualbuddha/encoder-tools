require 'thor'
require 'thor/group'

module EncoderTools
  class CLI < Thor
    autoload :Base,      'encoder-tools/cli/base'
    autoload :Subtitles, 'encoder-tools/cli/subtitles'

    desc "renumber [--input=FILE] [--output=FILE]", "Renumber badly-numbered SRT subtitle text"
    method_option :input,  :type => :string, :required => false, :aliases => %w[-i]
    method_option :output, :type => :string, :required => false, :aliases => %w[-o]
    def renumber
      CLI::Subtitles::Renumber.run(self, options)
    end

    desc "offset [--input=FILE] [--output=FILE] [+-]OFFSET", "Change the SRT subtitle offset to OFFSET or by +/-OFFSET"
    method_option :input,  :type => :string, :required => false, :aliases => %w[-i]
    method_option :output, :type => :string, :required => false, :aliases => %w[-o]
    def offset(offset)
      CLI::Subtitles::Offset.run(self, options.merge(:offset => offset))
    end

    desc "fix-lengths", "Interactively fix subtitle lengths over N seconds"
    method_option :input,     :type => :string,  :required => true, :aliases => %w[-i]
    method_option :output,    :type => :string,  :required => true, :aliases => %w[-o]
    method_option :threshold, :type => :numeric, :required => true, :aliases => %w[-t], :default => CLI::Subtitles::FixLengths::DEFAULT_THRESHOLD
    def fix_lengths
      CLI::Subtitles::FixLengths.run(self, options)
    end
  end
end
