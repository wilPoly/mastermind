# frozen_string_literal: true

# Board class: handles the content of the board
class Board
  attr_reader :secret_combo

  def initialize(secret_combo)
    @secret_combo = secret_combo
    @guesses = []
    @feedbacks = []
  end

  def put_pegs(guess, feedback)
    @guesses << guess
    @feedbacks << feedback
  end

  def display_board
    @guesses.each_with_index do |guess, i|
      puts "| #{guess.join(' ')} |\t| #{@feedbacks[i].join(' ')} |"
    end
  end
end
