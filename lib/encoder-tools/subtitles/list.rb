module EncoderTools
  module Subtitles
    class List
      attr_accessor :entries

      def offset
        entries.first.offset
      end

      def offset=(offset)
        diff = offset - self.offset
        entries.each {|subtitle| subtitle.offset += diff}
      end

      def to_s
        str = ""
        i = 0
        entries.each do |subtitle|
          str << (i += 1).to_s << "\n" << subtitle.to_s << "\n\n"
        end

        return str
      end

      def self.load(input, parser_class=Parser)
        result = new
        parser = parser_class.new(input)
        result.entries = parser.parse
        return result
      end
    end
  end
end
