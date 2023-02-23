# frozen_string_literal: true

module Mastermind
  module GameMode
    module EncryptSteps
      class HandleOriginalVariables
        class << self
          attr_accessor :chosen_colors, :preparation

          def call!(guess:, original_guess:, original_colors:, chosen_colors:, preparation:)
            set_variables(chosen_colors, preparation)

            guess.each_with_index do |el, idx|
              if correct_guess?(el, idx)
                handle_correct_guess(original_guess, original_colors, el, idx)
              else
                remove_color(original_colors, el)
              end
            end
          end

          private

          def set_variables(chosen_colors, preparation)
            @chosen_colors = chosen_colors
            @preparation = preparation
          end

          def correct_guess?(element, index)
            @chosen_colors[index] == element
          end

          def handle_correct_guess(original_guess, original_colors, element, idx)
            original_guess[idx] = element
            remove_color(original_colors, element)
          end

          def remove_color(colors_array, element)
            colors_array.delete(element) unless @preparation.duplicate
          end
        end
      end
    end
  end
end
