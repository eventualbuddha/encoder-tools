require 'set'

module EncoderTools
  class CLI
    module Subtitles
      class SpellCheck < Base
        DEFAULT_DICT = '/usr/share/dict/words'.freeze

        def run
          write(read.each do |subtitle|
            subtitle.text.gsub!(/\w+/) do |word|
              fix_word(word)
            end
          end)
        end

        private

        def fix_word(word)
          return word if word?(word)
          fix_ls_that_should_be_is(word)
        end

        def fix_ls_that_should_be_is(word)
          # example: word == "bllllng"

          ls = []

          word.each_char.with_index do |char, i|
            ls << i if char == 'l'
          end

          # ls == [1, 2, 3, 4]

          ls.size.downto(1) do |n|
            # substitute all 'l' with 'i' to start, then one less, etc
            ls.combination(n) do |to_change|
              # to_change == [1, 2, 3, 4], then [1, 2, 3], [1, 3, 4], etc
              candidate = word.dup
              to_change.each do |pos|
                candidate[pos] = 'i'
              end
              # candidate == "biiiing", "biliing", "biiling", etc
              return candidate if word?(candidate)
            end
          end

          return word
        end

        def word?(word)
          words.include?(word.downcase)
        end

        def words
          @words ||= read_words
        end

        def read_words
          if dict
            Set.new(File.read(dict).split($/).map {|w| w.downcase })
          else
            raise ArgumentError, "Must provide a dictionary of valid words"
          end
        end

        def dict
          options.fetch(:dict, File.exist?(DEFAULT_DICT) ? DEFAULT_DICT : nil)
        end
      end
    end
  end
end
