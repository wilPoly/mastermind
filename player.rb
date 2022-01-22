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

# Codebreaker role
module CodeBreaker
  # Specifics for human player
  class Human < Player; end
  # Specifics for AI player
  class Computer < Player; end
end

# Codemaster role
module CodeMaster
  # Specifics for human player
  class Human < Player; end

  # Specifics for AI player
  class Computer < Player
    def feedback(combo, guess)
      black = 0
      white = 0
      guess.each_with_index do |peg, i|
        if combo[i] == peg
          black += 1
        elsif combo.count(peg) == guess.count(peg)
          white += 1
        end
      end
      black == 4 ? (puts 'Correct!') : [black, white]
    end
  end
end
