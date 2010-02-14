module EncoderTools
  class CLI
    module Subtitles
      class Offset < Base
        def run
          output << offset(parse(input.read), options[:offset]).to_s
        end

        protected
          def offset(list, offset)
            list.offset = parse_offset(list, offset)
            return list
          end

          def parse_offset(list, offset)
            case offset
            when Fixnum
              offset
            when /^\+(\d+)$/
              list.offset + $1.to_i
            when /^-(\d+)$/
              list.offset - $1.to_i
            when /^\d+$/
              offset.to_i
            end
          end
      end
    end
  end
end
