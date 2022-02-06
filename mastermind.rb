# frozen_string_literal: true

require_relative './board'
require_relative './player'

# Game engine
class Game
  TURNS = 12

  def initialize
    @cpu_player = Computer.new('Hal')
    @human_player = Human.new('Hooman')
    new_game
  end

  def choose_role
    case @human_player.last_role
    when nil
      puts "How do you want to play?\n1. Codemaster || 2. Codebreaker"
      assign_role(gets.chomp.to_i)
    when 'codemaster'
      assign_role(2) # Human player switches to codebreaker
    when 'codebreaker'
      assign_role(1) # Human player switches to codemaster
    end
  end

  def assign_role(response)
    case response
    when 1
      @codemaster = @human_player
      @codebreaker = @cpu_player
      @human_player.last_role = 'codemaster'
    when 2
      @codemaster = @cpu_player
      @codebreaker = @human_player
      @human_player.last_role = 'codebreaker'
    end
  end

  def new_game
    puts @cpu_player.to_s
    puts @human_player.to_s
    @cpu_player.new_game
    choose_role
    puts "You play as #{@human_player.last_role}"
    @board = Board.new(@codemaster.define_secret)
    round
  end

  def codebreaker_win
    puts "#{@codebreaker.name} guessed the secret combo!"
    new_game
  end

  def codemaster_win
    puts "#{@codemaster.name} wins."
    @codemaster.score += 1
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
      @codemaster.score += 1
      codebreaker_win if @board.feedbacks.last == [4, 0]
      puts "#{@turns_left -= 1} turns left"
    end
    codemaster_win
  end
end

Game.new
# game.round
# game.choose_role
