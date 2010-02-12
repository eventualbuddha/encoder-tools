module EncoderTools
  module Subtitles
    class Subtitle
      attr_accessor :range, :text

      def initialize(range, text)
        @range, @text = range, text
      end

      def offset
        range.begin
      end

      def offset=(offset)
        self.range = offset..(offset + duration)
      end

      def duration
        range.end - range.begin
      end

      def ==(other)
        other.is_a?(self.class) &&
          other.range == self.range &&
          other.text == self.text
      end

      def to_s
        "#{timestamp range.begin} --> #{timestamp range.end}\n#{text}"
      end

      private
      def timestamp(value)
        seconds = value.to_i
        millis = ((value - seconds) * 1000).to_i
        minutes, seconds = seconds.divmod(60)
        hours, minutes = minutes.divmod(60)

        "%02d:%02d:%02d,%03d" % [hours, minutes, seconds, millis]
      end
    end
  end
end
