module EncoderTools
  class CLI
    module Subtitles
      class Offset < Base
        NUMBER = '(\d+|\d*\.\d+)'
        HH_MM_SS_OFFSET = %r{\A(?:(\d\d?):)?(\d\d?):(\d\d?)\Z}
        ABSOLUTE_OFFSET = %r{\A#{NUMBER}\Z}
        NEGATIVE_OFFSET = %r{\A-#{NUMBER}\Z}
        POSITIVE_OFFSET = %r{\A\+#{NUMBER}\Z}

        MIN_PER_HOUR = 60
        SEC_PER_MIN  = 60

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
            when HH_MM_SS_OFFSET
              ((BigDecimal($1 || '0') * MIN_PER_HOUR) + BigDecimal($2)) * SEC_PER_MIN + BigDecimal($3)
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
