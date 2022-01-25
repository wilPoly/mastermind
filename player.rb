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

  def to_s
    "#{@name} - score: #{@score}"
  end
end

# Specifics for human player
class Human < Player
  def guess_combo
    valid_entry = false
    until valid_entry
      puts 'Enter a 4-number combination with numbers from 1 to 6'
      guess = gets.chomp.split('').map(&:to_i)
      valid_entry = (guess.length == 4) && guess.all? { |number| number <= 6 && number.is_a?(Integer) }
    end
    guess
  end
end

# Specifics for AI player
class Computer < Player
  def define_secret
    Array.new(5) { rand(1..6) }
  end

  def give_feedback(secret, guess)
    black = 0
    white = 0
    guess.each_with_index do |peg, i|
      if secret[i] == peg
        black += 1
      elsif secret.count(peg) == guess.count(peg)
        white += 1
      end
    end
    [black, white]
  end
end

# human = Human.new('Will', 'Codebreaker')
# cpu = Computer.new('Hal', 'Codemaster')

# combo = cpu.define_secret

# cpu.give_feedback(combo, human.guess_combo)

# p human
# p cpu

# p human.class
# p cpu.class

# p Human.ancestors
# p Computer.ancestors
