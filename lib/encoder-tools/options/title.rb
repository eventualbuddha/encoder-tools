require 'singleton'

module EncoderTools
  module Options
    class Title
      attr_accessor :number

      def initialize(number)
        @number = number
      end

      def ==(other)
        other.is_a?(self.class) && other.number == self.number
      end

      def to_args
        ['--title', number.to_s]
      end

      class Longest < Title
        include Singleton

        def initialize
          super(nil)
        end

        def to_args
          %w[--longest]
        end
      end
      LONGEST = Longest.instance
    end
  end
end
