# frozen_string_literal: true

# General Player class
class Player
  attr_reader :name
  attr_accessor :role, :score

  def initialize(name, score: 0)
    @name = name
    @score = score
  end

  def to_s
    "#{@name} - score: #{@score}"
  end
end

# Specifics for human player
class Human < Player
  def combo_input
    valid_entry = false
    until valid_entry
      puts 'Enter a 4-number combination with numbers from 1 to 6'
      combo = gets.chomp.split('').map(&:to_i)
      valid_entry =
        (combo.length == 4) && combo.all? { |number| number.is_a?(Integer) && number.positive? && number <= 6 }
    end
    combo
  end

  def guess_combo
    combo_input # use alias_method ???
  end

  def define_secret
    combo_input
  end
end

# Specifics for AI player
class Computer < Player
  def define_secret
    Array.new(4) { rand(1..6) }
  end

  def count_pegs(secret, guess)
    secret_count = []
    guess_count = []

    (1..6).each do |i|
      secret_count << secret.count(i)
      guess_count << guess.count(i)
    end

    secret_count.each_index.reduce(0) do |sum, i|
      sum += [secret_count[i], guess_count[i]].min
      sum
    end
  end

  def count_blacks(secret, guess)
    guess.each_index.reduce(0) do |sum, i|
      sum += 1 if secret[i] == guess[i]
      sum
    end
  end

  def count_whites(secret, guess)
    count_pegs(secret, guess) - count_blacks(secret, guess)
  end

  def give_feedback(secret, guess)
    [count_blacks(secret, guess), count_whites(secret, guess)]
  end
end
