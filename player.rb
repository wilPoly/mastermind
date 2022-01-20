# frozen_string_literal: true

# General Player class
class Player
  attr_reader :name, :role
  attr_accessor :score

  def initialize(name, role, score: 0)
    @name = name
    @role = role
    @score = score
  end
end

# Specifics for human player
class Human < Player
end

# Specifics for AI player
class Computer < Player
end
