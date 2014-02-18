module EncoderTools
  class CLI
    module Subtitles
      class Base < CLI::Base
        def self.parser(parser=nil)
          case parser
          when nil
            @parser || EncoderTools::Subtitles::Parser
          when :default
            @parser = EncoderTools::Subtitles::Parser
          when :relaxed
            @parser = EncoderTools::Subtitles::RelaxedParser
          when Class
            @parser = parser
          else
            raise ArgumentError, "unexpected parser type: #{parser.inspect}"
          end
        end

        def parser
          self.class.parser
        end

        def parse(text)
          EncoderTools::Subtitles::List.load(text, parser)
        end

        def read
          parse(input.read)
        end

        def write(result)
          output << result.to_s
        end
      end
    end
  end
end
