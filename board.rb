# frozen_string_literal: true

# Board class: handles the content of the board
class Board
  attr_reader :secret_combo

  def initialize(secret_combo)
    @board = {}
    @secret_combo = secret_combo
  end
end
