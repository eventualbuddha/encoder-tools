module EncoderTools
  class CLI
    module Subtitles
      class Base < CLI::Base
        def parse(text)
          EncoderTools::Subtitles::List.load(text)
        end

        def parse_relaxed(text)
          EncoderTools::Subtitles::List.load(text, EncoderTools::Subtitles::RelaxedParser)
        end
      end
    end
  end
end
