module EncoderTools
  class CLI
    module Subtitles
      autoload :Base,       'encoder-tools/cli/subtitles/base'
      autoload :FixLengths, 'encoder-tools/cli/subtitles/fix_lengths'
      autoload :Offset,     'encoder-tools/cli/subtitles/offset'
      autoload :Renumber,   'encoder-tools/cli/subtitles/renumber'
      autoload :SpellCheck, 'encoder-tools/cli/subtitles/spell_check'
    end
  end
end
