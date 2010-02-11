module EncoderTools
  module Encoders
    class Base
      attr_reader :input_path, :title

      def initialize(input_path)
        @input_path = input_path
      end

      def title=(title)
        case title
        when Options::Title, nil
          @title = title
        when Fixnum
          @title = Options::Title.new(title)
        else
          raise ArgumentError, "expected an #{Options::Title} or #{Fixnum}, got #{title.inspect}"
        end
      end
    end
  end
end
