require 'thor'

module EncoderTools
  class CLI < Thor
    autoload :Base,       'encoder-tools/cli/base'
    autoload :Subtitles,  'encoder-tools/cli/subtitles'

    desc "renumber [--input=FILE] [--output=FILE]", "Renumber badly-numbered SRT subtitle text"
    method_option :input,  :type => :string, :required => false, :aliases => %w[-i]
    method_option :output, :type => :string, :required => false, :aliases => %w[-o]
    def renumber
      CLI::Subtitles::Renumber.run(self, options)
    end

    desc "offset [--set OFFSET] [--add OFFSET] [--subtract OFFSET]", "Change the SRT subtitle offset to OFFSET or by +/-OFFSET"
    method_option :input,    :type => :string, :required => false, :aliases => %w[-i]
    method_option :output,   :type => :string, :required => false, :aliases => %w[-o]
    method_option :set,      :type => :string, :required => false
    method_option :add,      :type => :string, :required => false
    method_option :subtract, :type => :string, :required => false
    def offset
      CLI::Subtitles::Offset.run(self, options)
    end

    desc "fix-lengths", "Interactively fix subtitle lengths over N seconds (defaults to #{CLI::Subtitles::FixLengths::DEFAULT_THRESHOLD})"
    method_option :input,     :type => :string,  :required => true, :aliases => %w[-i]
    method_option :output,    :type => :string,  :required => true, :aliases => %w[-o]
    method_option :threshold, :type => :numeric, :required => true, :aliases => %w[-t], :default => CLI::Subtitles::FixLengths::DEFAULT_THRESHOLD
    def fix_lengths
      CLI::Subtitles::FixLengths.run(self, options)
    end

    desc "spell-check [--dict DICT]", "Fix spelling in the subtitle file"
    method_option :input,  :type => :string, :required => false, :aliases => %w[-i]
    method_option :output, :type => :string, :required => false, :aliases => %w[-o]
    method_option :dict,   :type => :string, :required => false, :aliases => %w[-d]
    def spell_check
      CLI::Subtitles::SpellCheck.run(self, options)
    end
  end
end
