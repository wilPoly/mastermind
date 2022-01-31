# frozen_string_literal: true

require_relative './board'
require_relative './player'

# Game engine
class Game
  TURNS = 12

  def initialize
    @cpu_player = Computer.new('Hal', 'codemaster')
    @human_player = Human.new('Hooman', 'codebreaker')
  end

  def new_game
    # change
    choose_role
    @board = Board.new(@codemaster.define_secret)
  end

  def choose_role
    puts 'How do you want to play?'
    puts '1. Codemaster | 2. Codebreaker'
    response = gets.chomp.to_i
    until (response == 1 || response == 2)
      case response
      when 1
        @codemaster = @human_player
        @codebreaker = @cpu_player
        break
      when 2
        @codebreaker = @human_player
        @codemaster = @cpu_player
        break
      else
        response = gets.chomp.to_i
      end
    end
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
