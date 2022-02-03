# frozen_string_literal: true

require_relative './board'
require_relative './player'

# Game engine
class Game
  TURNS = 12

  def initialize
    p @cpu_player = Computer.new('Hal')
    p @human_player = Human.new('Hooman')
    new_game
  end

  def choose_role
    puts "How do you want to play?\n1. Codemaster || 2. Codebreaker"
    response = gets.chomp.to_i
    case response
    when 1
      @codemaster = @human_player
      @codebreaker = @cpu_player
    when 2
      @codemaster = @cpu_player
      @codebreaker = @human_player
    end
  end

  def new_game
    @cpu_player.new_game
    choose_role
    @board = Board.new(@codemaster.define_secret)
    round
  end

  def round
    @turns_left = TURNS
    until @turns_left.zero?
      p @board.secret_combo
      # Reminds the last guess and the last feedback given
      guess = @codebreaker.guess_combo(@board.guesses.last, @board.feedbacks.last)
      feedback = @codemaster.give_feedback(@board.secret_combo, guess)
      @board.put_pegs(guess, feedback)
      @board.display_board
      # win condition
      @turns_left -= 1
      puts @turns_left
    end
  end
end

Game.new
# game.round
# game.choose_role
