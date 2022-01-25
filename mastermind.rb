# frozen_string_literal: true

require_relative './board'
require_relative './player'

class Game
  def initialize
    @codemaster = Computer.new('Hal', 'codemaster')
    @codebreaker = Human.new('Hooman', 'codebreaker')
    @board = Board.new(@codemaster.define_secret)
  end

  def round
    until @board.rows.length == 12
      p @board.secret_combo
      guess = @codebreaker.guess_combo
      feedback = @codemaster.give_feedback(@board.secret_combo, guess)
      @board.rows[guess] = feedback
      @board.display_board
    end
  end
end

game = Game.new
game.round
