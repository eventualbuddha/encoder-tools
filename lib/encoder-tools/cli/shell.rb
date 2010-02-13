require 'stringio'

module EncoderTools
  module CLI
    class Shell
      def self.stdin
        @@stdin
      end

      def self.stdin=(stream)
        @@stdin = stream
      end

      def self.stdout
        @@stdout
      end

      def self.stdout=(stream)
        @@stdout = stream
      end

      def self.stderr
        @@stderr
      end

      def self.stderr=(stream)
        @@stderr = stream
      end

      self.stdin  = $stdin
      self.stdout = $stdout
      self.stderr = $stderr

      def self.capture(stream, buffer="")
        old_stream  = __send__(stream)
        new_stream = StringIO.new(buffer)
        __send__("#{stream}=", new_stream)
        yield if block_given?
        return new_stream.string
      ensure
        __send__("#{stream}=", old_stream)
      end
    end
  end
end
