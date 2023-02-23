# frozen_string_literal: true

require './config/set_game_configuration'
require './mastermind/prepare'
require './output/messages'
require './mastermind/validation/prepare'
require './mastermind/setup'
require './mastermind/play'
require './mastermind/game_mode/encrypt'
require './mastermind/game_mode/encrypt_steps/handle_original_variables'

class Game
  def self.init!
    preparation = Mastermind::Prepare.run!
    system 'clear'
    chosen_colors = Mastermind::Setup.run!(preparation)

    Mastermind::Play.game!(preparation, chosen_colors)
  end
end

Game.init!
