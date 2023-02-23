# frozen_string_literal: true

module Config
  class SetGameConfiguration
    attr_accessor :attempt, :qtd_colors, :blank_space, :duplicate, :game_mode

    COLORS_ARRAY = %w[ROXO AMARELO VERMELHO VERDE AZUL LARANJA ROSA CINZA PRETO BRANCO].freeze
    ATTEMPT = { very_easy: 12, easy: 8, medium: 12, hard: 8, too_hard: 8 }.freeze
    QTD_COLORS = { very_easy: 6, easy: 6, medium: 8, hard: 8, too_hard: 10 }.freeze
    BOOLEAN_QUESTION = [true, false].freeze
    GAME_MODE = %i[encrypt decrypt].freeze

    def initialize(difficult, blank_space, duplicate, game_mode)
      self.attempt = ATTEMPT[difficult]
      self.qtd_colors = QTD_COLORS[difficult]
      self.blank_space = BOOLEAN_QUESTION[blank_space]
      self.duplicate = BOOLEAN_QUESTION[duplicate]
      self.game_mode = GAME_MODE[game_mode]
    end
  end
end
