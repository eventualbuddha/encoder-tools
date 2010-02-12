module EncoderTools
  module Subtitles
    class RelaxedParser < Parser
      protected
      def scan_index
        scan /\d+/
        newline
      end
    end
  end
end
