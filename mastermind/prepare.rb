# frozen_string_literal: true

module Mastermind
  class Prepare
    DIFFICULTY = %i[very_easy easy medium hard too_hard].freeze

    class << self
      def run!
        mastermind = new
        mastermind.welcome_message

        Config::SetGameConfiguration.new(
          mastermind.choose_difficulty,
          mastermind.is_it_possible_to_have_blank_spaces?,
          mastermind.allow_duplicate?,
          mastermind.game_mode
        )
      end
    end

    def initialize
      @messages = Output::Messages.new
      @validation = Validation::Prepare.new
    end

    def welcome_message
      @messages.welcome
    end

    def choose_difficulty
      @messages.choose_your_difficulty
      choice = gets

      return DIFFICULTY[choice.to_i - 1] if @validation.difficulty_choice_is_valid?(choice)

      @messages.invalid_difficulty_choice
      choose_difficulty
    end

    def is_it_possible_to_have_blank_spaces?
      @messages.allow_blank_spaces
      choice = gets

      return (choice.to_i - 1) if @validation.blank_spaces_choice_is_valid?(choice)

      @messages.invalid_boolean_choice
      is_it_possible_to_have_blank_spaces?
    end

    def allow_duplicate?
      @messages.allow_duplicate
      choice = gets

      return (choice.to_i - 1) if @validation.allow_duplicate_choice_is_valid?(choice)

      @messages.invalid_boolean_choice
      allow_duplicate?
    end

    def game_mode
      @messages.encrypt_or_decrypt
      choice = gets

      return (choice.to_i - 1) if @validation.encrypt_or_decrypt_is_valid?(choice)

      @messages.invalid_boolean_choice
      encrypt_or_decrypt?
    end
  end
end
