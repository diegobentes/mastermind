# frozen_string_literal: true

require 'byebug'

module Mastermind
  class Play
    class << self
      def game!(preparation, chosen_colors)
        game = new(preparation, chosen_colors)
        game.play
      end
    end

    def initialize(preparation, chosen_colors)
      @preparation = preparation
      @chosen_colors = chosen_colors
    end

    def play
      modifier = @preparation.blank_space ? 1 : 0

      colors = Config::SetGameConfiguration::COLORS_ARRAY
      qtd_colors = @preparation.qtd_colors - 1

      if @preparation.game_mode === :decrypt
        decrypt_game_mode(modifier, colors, qtd_colors)
      else
        Mastermind::GameMode::Encrypt.play!(@preparation, @chosen_colors)
      end

      puts "\n\nResposta Correta: #{@chosen_colors}"
    end

    private

    def decrypt_game_mode(modifier, colors, qtd_colors)
      (1..@preparation.attempt).each do |try|
        clear_screen(try, false)

        guess = []

        (1..4).each do |idx|
          puts "Selecione a cor para a posição #{idx}:\n\n"

          puts "Resposta parcial: #{guess}\n\n"

          puts '0 - VAZIO (nil)' if @preparation.blank_space

          colors[modifier..qtd_colors].each_with_index do |color, idx|
            puts "#{idx + 1} - #{color}"
          end

          choose = gets

          guess << if @preparation.blank_space && choose.to_i.zero?
                     nil
                   elsif @preparation.blank_space
                     Config::SetGameConfiguration::COLORS_ARRAY[choose.to_i]
                   else
                     Config::SetGameConfiguration::COLORS_ARRAY[choose.to_i - 1]
                   end

          clear_screen(try)
        end

        guess.each_with_index do |el, idx|
          if @chosen_colors.find_index(el) === idx && @chosen_colors.include?(el)
            puts "O elemento #{el.nil? ? 'VAZIO' : el} está na posição correta"
          elsif @chosen_colors.include?(el)
            puts "O elemento #{el.nil? ? 'VAZIO' : el} existe no array mas está na posição errada"
          else
            puts "O elemento #{el.nil? ? 'VAZIO' : el} não existe no array"
          end
        end

        return puts 'CORRETO!' if guess === @chosen_colors

        puts "\n\nSua última resposta: #{guess}\n\n"
      end
    end

    def clear_screen(try, clear = true)
      system 'clear' if clear
      puts "\n\n== TENTATIVA #{try} de #{@preparation.attempt} ==\n\n"
    end
  end
end
