# frozen_string_literal: true

module Mastermind
  module GameMode
    # Class with the responsibility of managing the encrypt game mode
    class Encrypt
      class << self
        def play!(preparation, chosen_colors)
          set_variables(preparation, chosen_colors)
          encrypt
        end

        private

        def set_variables(preparation, chosen_colors)
          @preparation = preparation
          @chosen_colors = chosen_colors
          @messages = Output::Messages.new
        end

        def encrypt
          encrypt_loop(**setup)
        end

        def setup
          limit_colors = build_limit_colors

          {
            original_guess: ['', '', '', ''],
            original_colors: build_original_colors(limit_colors)
          }
        end

        def encrypt_loop(original_guess:, original_colors:)
          (1..@preparation.attempt).each do |try|
            guess = build_guess(original_colors, original_guess)
            @messages.encrypt_try(try, @preparation.attempt, guess)

            if guess_correct?(guess)
              @messages.encrypt_correct(original_guess)
              break
            end

            handle_original_variables(guess, original_guess, original_colors)
            @messages.encrypt_correct(original_guess)
          end
        end

        def build_limit_colors
          @preparation.blank_space ? @preparation.qtd_colors - 2 : @preparation.qtd_colors - 1
        end

        def build_original_colors(limit_colors)
          original_colors = []
          original_colors << nil if @preparation.blank_space
          original_colors << Config::SetGameConfiguration::COLORS_ARRAY[0..limit_colors]
          original_colors.flatten!
        end

        def build_guess(original_colors, original_guess)
          guess = []

          4.times do |idx|
            choose = original_colors.sample

            if original_guess[idx] != ''
              guess << original_guess[idx]
            else
              guess[idx] = choose
            end
          end

          guess
        end

        def guess_correct?(guess)
          return unless @chosen_colors == guess

          @messages.encrypt_win
          true
        end

        def handle_original_variables(guess, original_guess, original_colors)
          EncryptSteps::HandleOriginalVariables.call!(
            guess: guess,
            original_guess: original_guess,
            original_colors: original_colors,
            chosen_colors: @chosen_colors,
            preparation: @preparation
          )
        end
      end
    end
  end
end
