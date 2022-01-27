# frozen_string_literal: true

require_relative './board'
require_relative './player'

# Game engine
class Game
  TURNS = 12

  def initialize
    @codemaster = Computer.new('Hal', 'codemaster')
    @codebreaker = Human.new('Hooman', 'codebreaker')
    @board = Board.new(@codemaster.define_secret)
  end

  def round
    @turns_left = TURNS
    until @turns_left.zero?
      p @board.secret_combo
      guess = @codebreaker.guess_combo
      feedback = @codemaster.give_feedback(@board.secret_combo, guess)
      @board.put_pegs(guess, feedback)
      @board.display_board
      @turns_left -= 1
      puts @turns_left
    end
  end
end

game = Game.new
game.round
