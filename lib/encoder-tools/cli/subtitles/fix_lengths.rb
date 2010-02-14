module EncoderTools
  class CLI
    module Subtitles
      class FixLengths < Base
        THRESHOLD = 5

        def run
          if long_subtitles.empty?
            shell.say "No subtitles found over #{THRESHOLD}s"
            return
          end

          if not shell.yes?("Found #{long_subtitles.size} long subtitles. Would you like to fix them?")
            return
          end

          long_subtitles.each do |subtitle|
            lines = subtitle.to_s.to_a
            range = lines.shift.chomp
            range += " (#{subtitle.duration.to_i}s)\n"
            lines.unshift(range)
            lines << "\n" << "\n"

            shell.say(lines.join)
            subtitle.duration = shell.ask("How long should it be?").to_i
          end

          output << list.to_s

          return nil
        end

        private
          def long_subtitles
            @long_subtitles ||= list.entries.select do |subtitle|
              subtitle.duration > THRESHOLD
            end
          end

          def list
            @list ||= parse(input.read)
          end
      end
    end
  end
end
