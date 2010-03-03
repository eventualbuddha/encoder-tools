module EncoderTools
  class CLI
    module Subtitles
      class Offset < Base
        NUMBER = '(\d+|\d*\.\d+)'
        ABSOLUTE_OFFSET = %r{^#{NUMBER}$}
        NEGATIVE_OFFSET = %r{^-#{NUMBER}$}
        POSITIVE_OFFSET = %r{^\+#{NUMBER}$}

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
            when POSITIVE_OFFSET
              list.offset + BigDecimal($1)
            when NEGATIVE_OFFSET
              list.offset - BigDecimal($1)
            when ABSOLUTE_OFFSET
              BigDecimal(offset)
            end
          end
      end
    end
  end
end
