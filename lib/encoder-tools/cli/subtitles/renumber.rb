module EncoderTools
  class CLI
    module Subtitles
      class Renumber < Base
        def run
          output << parse_relaxed(input.read).to_s
        end
      end
    end
  end
end
