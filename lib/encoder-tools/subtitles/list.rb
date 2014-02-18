module EncoderTools
  module Subtitles
    class List
      attr_accessor :entries

      def offset
        return 0 if entries.empty?
        entries.first.offset
      end

      def offset=(offset)
        return nil if entries.empty?
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

      def each(&block)
        entries.each(&block)
        return self
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
