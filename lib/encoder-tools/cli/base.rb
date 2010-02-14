module EncoderTools
  class CLI
    class Base
      attr_reader :options

      def initialize(shell, options={})
        @shell, @options = shell, options
      end

      def run
        # overridden in subclasses
      end

      private
        def input
          @input ||= @options[:input] ?
            open(@options[:input]) :
            $stdin
        end

        def output
          @output ||= @options[:output] ?
            open(@options[:output], 'w') :
            $stdout
        end

        def open(stream_or_file, mode='r')
          if stream_or_file.respond_to?(:eof?)
            stream_or_file
          else
            File.open(stream_or_file, mode)
          end
        end

      def self.run(shell, options={})
        new(shell, options).run
      end
    end
  end
end
