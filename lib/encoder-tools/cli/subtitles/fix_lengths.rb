module EncoderTools
  class CLI
    module Subtitles
      class FixLengths < Base
        DEFAULT_THRESHOLD = 5

        def run
          begin
            if long_subtitles? && fix_subtitles?
              output << fix_subtitles.to_s
            end

            return nil
          rescue Interrupt
            # just return on ^C
          end
        end

        private
          def long_subtitles?
            return true if long_subtitles.any?

            shell.say "No subtitles found over #{threshold}s"
            return false
          end

          def fix_subtitles?
            shell.yes?("Found #{long_subtitles.size} long subtitles. Would you like to fix them?")
          end

          def fix_subtitles
            long_subtitles.each do |subtitle|
              fix_subtitle(subtitle)
            end
            return list
          end

          def fix_subtitle(subtitle)
            range = "#{subtitle.range_string} (#{subtitle.duration.to_i}s)"
            shell.say([range, subtitle.text, '', ''].join("\n"))
            subtitle.duration = shell.ask("How long should it be?").to_i
          end

          def long_subtitles
            @long_subtitles ||= list.entries.select do |subtitle|
              subtitle.duration > threshold
            end
          end

          def list
            @list ||= parse(input.read)
          end

          def threshold
            options[:threshold] || DEFAULT_THRESHOLD
          end
      end
    end
  end
end
