module EncoderTools
  module Encoders
    class Movie < Base
      def initialize(input_path)
        super
        self.title = Options::Title::LONGEST
      end
    end
  end
end
