# frozen_string_literal: true

# Board class: handles the content of the board
class Board
  attr_accessor :rows
  attr_reader :secret_combo

  def initialize(secret_combo)
    @rows = {}
    @secret_combo = secret_combo
  end

  def display_board
    @rows.each do |guess, feedback|
      puts "| #{guess.join(' ')} |\t| #{feedback.join(' ')} |"
    end
  end
end
