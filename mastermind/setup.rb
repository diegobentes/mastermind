# frozen_string_literal: true

module Mastermind
  class Setup
    attr_accessor :preparation, :chosen_colors

    class << self
      def run!(preparation)
        setup = new(preparation)

        setup.choose_colors(Config::SetGameConfiguration::COLORS_ARRAY)
      end
    end

    def initialize(preparation)
      @preparation = preparation
      @chosen_colors = []
    end

    def choose_colors(colors)
      return encrypt(colors) if @preparation.game_mode == :encrypt

      decrypt(colors)
    end

    private

    def encrypt(colors)
      puts 'Crie sua codificação!'
      puts 'Escolha 4 cores! Lembre-se que o decodificador precisará acertar na ordem correta!'

      qtd_colors = @preparation.qtd_colors - 1

      (1..4).each do |index_color|
        puts '0 - NULO (Espaço em Branco)' if @preparation.blank_space

        colors[0..qtd_colors].each_with_index do |color, idx|
          puts "#{idx + 1} - #{color}"
        end

        puts "Escolha a cor número #{index_color}:"

        @chosen_colors << if @preparation.blank_space
                            Config::SetGameConfiguration::COLORS_ARRAY[gets.to_i]
                          else
                            Config::SetGameConfiguration::COLORS_ARRAY[gets.to_i - 1]
                          end
      end

      @chosen_colors
    end

    def decrypt(_colors)
      puts 'Criando codificação...'

      modifier = @preparation.blank_space ? 1 : 0
      qtd_colors = @preparation.qtd_colors - 1

      @chosen_colors = if @preparation.duplicate
                         4.times.map { rand(modifier..qtd_colors) }
                       else
                         (modifier..qtd_colors).to_a.sample(4)
                       end

      @chosen_colors.map do |cc|
        if @preparation.blank_space && cc === 0
          nil
        else
          Config::SetGameConfiguration::COLORS_ARRAY[cc]
        end
      end
    end
  end
end
