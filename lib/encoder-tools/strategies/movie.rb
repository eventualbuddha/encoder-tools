module EncoderTools
  module Strategies
    class Movie < Base
      def initialize(input_path)
        super
        self.title = Options::Title::LONGEST
      end
    end
  end
end
