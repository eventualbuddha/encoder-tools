module EncoderTools
  class CLI
    module Subtitles
      class Renumber
        def initialize(shell, options={})
          @shell, @options = shell, options
        end

        def run
          output << convert_to_string_with_new_subtitle_numbers(parse_disregarding_subtitle_numbers(input.read))
        end

        private

        def convert_to_string_with_new_subtitle_numbers(list)
          list.to_s
        end

        def parse_disregarding_subtitle_numbers(text)
          EncoderTools::Subtitles::List.load(text, EncoderTools::Subtitles::RelaxedParser)
        end

        def input
          @input ||= @options[:input] ?
            open(@options[:input]) :
            $stdin
        end

        def output
          @output ||= @options[:output] ?
            open(@options[:output], 'w') :
            $stdout
        end

        def open(stream_or_file, mode='r')
          if stream_or_file.respond_to?(:eof?)
            stream_or_file
          else
            File.open(stream_or_file, mode)
          end
        end

        def self.run(*args)
          new(*args).run
        end
      end
    end
  end
end
