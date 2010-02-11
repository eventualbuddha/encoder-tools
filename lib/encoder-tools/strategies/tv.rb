module EncoderTools
  module Strategies
    class TV < Base
      def initialize(input_path)
        super
        self.title = 1
      end
    end
  end
end
