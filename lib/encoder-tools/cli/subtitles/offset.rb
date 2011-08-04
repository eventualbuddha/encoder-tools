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
          value = if options[:set]
                    options[:set]
                  elsif options[:add]
                    "+#{options[:add]}"
                  elsif options[:subtract]
                    "-#{options[:subtract]}"
                  else
                    raise ArgumentError, "Must provide a set, add, or subtract option to determine the offset"
                  end

          output << offset(parse(input.read), value).to_s
        end

        protected
          def offset(list, value)
            list.offset = parse_offset(list, value)
            return list
          end

          def parse_offset(list, value)
            case value
            when Fixnum
              value
            when HH_MM_SS_OFFSET
              ((BigDecimal($1 || '0') * MIN_PER_HOUR) + BigDecimal($2)) * SEC_PER_MIN + BigDecimal($3)
            when POSITIVE_OFFSET
              list.offset + BigDecimal($1)
            when NEGATIVE_OFFSET
              list.offset - BigDecimal($1)
            when ABSOLUTE_OFFSET
              BigDecimal(value)
            end
          end
      end
    end
  end
end
