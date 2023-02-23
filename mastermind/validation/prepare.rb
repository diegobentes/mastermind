# frozen_string_literal: true

module Validation
  class Prepare
    def difficulty_choice_is_valid?(choice)
      return true if choice.respond_to?(:to_i) && (choice.to_i >= 1 && choice.to_i <= 5)

      false
    end

    def blank_spaces_choice_is_valid?(choice)
      boolean_validate(choice)
    end

    def allow_duplicate_choice_is_valid?(choice)
      boolean_validate(choice)
    end

    def encrypt_or_decrypt_is_valid?(choice)
      boolean_validate(choice)
    end

    private

    def boolean_validate(choice)
      return true if choice.respond_to?(:to_i) && (choice.to_i >= 1 && choice.to_i <= 2)

      false
    end
  end
end
