module EncoderTools
  module CLI
    module Subtitles
      class Renumber
        def initialize(shell, args=[])
          @shell, @args = shell, args
        end

        def run
          write(convert_to_string_with_new_subtitle_numbers(parse_disregarding_subtitle_numbers(read)))
        end

        private

        def write(output)
          @shell.stdout << output
        end

        def convert_to_string_with_new_subtitle_numbers(list)
          list.to_s
        end

        def parse_disregarding_subtitle_numbers(text)
          EncoderTools::Subtitles::List.load(text, EncoderTools::Subtitles::RelaxedParser)
        end

        def read
          @shell.stdin.read
        end
      end
    end
  end
end
