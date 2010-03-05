module EncoderTools
  module Util
    class TextReader
      ENCODING_MARKER = "\xef\xbb\xbf".freeze

      def initialize(input)
        @input = input
      end

      def read
        strip_encoding_marker(
          @input.respond_to?(:read) ?  @input.read : @input)
      end

      def self.read(input)
        new(input).read
      end

      private
        def strip_encoding_marker(string)
          string[0, ENCODING_MARKER.size] == ENCODING_MARKER ?
            string[ENCODING_MARKER.size..-1] : string
        end
    end
  end
end
