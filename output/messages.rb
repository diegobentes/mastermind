# frozen_string_literal: true

module Output
  class Messages
    def welcome
      puts "Seja bem vindo ao master mind!\n\n"
    end

    def choose_your_difficulty
      puts 'Em qual dificuldade você quer jogar?'
      puts ''
      puts '1 - Muito Fácil'
      puts '2 - Fácil'
      puts '3 - Médio'
      puts '4 - Difícil'
      puts '5 - Muito Difícil'
      puts ''
      puts "Escolha a dificuldade (1-5): \n\n"
    end

    def invalid_difficulty_choice
      puts "\nDificultade inválida!"
      puts "Escolha uma dificuldade de 1 a 5.\n\n"
    end

    def allow_blank_spaces
      puts "\nÉ permitido ter espaços em branco?"
      puts '1 - Sim'
      puts "2 - Não\n\n"
    end

    def invalid_boolean_choice
      puts 'Resposta inválida!'
      puts 'Escolha entre SIM(1) ou NÃO(2).'
    end

    def allow_duplicate
      puts "\nÉ permitido duplicatas?"
      puts '1 - Sim'
      puts "2 - Não\n\n"
    end

    def encrypt_or_decrypt
      puts "\nVocê quer codificar ou decodificar?"
      puts '1 - Codificar'
      puts "2 - Decodificar\n\n"
    end

    def encrypt_try(try, attempt, guess)
      puts "\n\nTentativa: #{try} de #{attempt}"
      puts "\nPalpite: #{guess}"
    end

    def encrypt_correct(original_guess)
      puts "Acertou: #{original_guess}\n\n"
    end

    def encrypt_win
      puts 'VENCEU!'
    end
  end
end
