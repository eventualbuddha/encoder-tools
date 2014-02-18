module EncoderTools
  class CLI
    module Subtitles
      class Renumber < Base
        parser :relaxed

        def run
          write(read)
        end
      end
    end
  end
end
