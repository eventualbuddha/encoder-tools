require 'strscan'
require 'bigdecimal'

module EncoderTools
  module Subtitles
    class Parser
      class ParseError < RuntimeError; end

      def initialize(input)
        @scanner = StringScanner.new(input)
        @last_index = 0
      end

      def parse
        result = []
        result << scan_subtitle until @scanner.eos?
        return result
      end

      protected
      def scan_subtitle
        index = scan_index
        range = scan_timestamp_range
        text  = scan_text
        return Subtitle.new(range, text)
      end

      def scan_index
        # 1\n
        index = string @last_index += 1
        newline
        return index
      end

      def scan_timestamp_range
        # 01:15:18,000 --> 01:15:20,300\n
        rstart = timestamp
        string ' --> '
        rend = timestamp
        newline
        return rstart..rend
      end

      def scan_text
        # No wonder you can't do it... you acquiesce\n
        # to defeat... before you even begin.\n
        # \n
        text = ''
        loop do
          l = line
          break if l.nil? || l.strip.empty?
          text << l
        end
        text.strip!

        return text
      end

      def string(str)
        scan /#{Regexp.escape(str.to_s)}/
      end

      def timestamp
        hours = scan /\d\d/, 'hours'
        string ':'
        minutes = scan /\d\d/, 'minutes'
        string ':'
        seconds = scan /\d\d/, 'seconds'
        string ','
        millis = scan /\d\d\d/, 'milliseconds'

        return hours.to_i * 3600 + minutes.to_i * 60 + seconds.to_i + (BigDecimal(millis) / 1000)
      end

      def newline
        scan /\r?\n/, 'newline'
      end

      def line
        @scanner.scan_until(/\r?\n/)
      end

      def scan(scannable, name=nil)
        if scanned = @scanner.scan(scannable)
          return scanned
        else
          raise ParseError, "expected #{name || scannable.inspect} at character #{@scanner.pos}, got #{@scanner.string[@scanner.pos, 10].inspect}"
        end
      end

      def upto(scannable)
        @scanner.scan_until(scannable)
      end
    end
  end
end
