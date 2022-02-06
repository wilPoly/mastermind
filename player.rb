# frozen_string_literal: true

# General Player class
class Player
  attr_reader :name
  attr_accessor :score, :last_role

  def initialize(name, score: 0)
    @name = name
    @score = score
  end

  def to_s
    "#{@name}'s score: #{@score}"
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
        (combo.length == 4) && combo.all? { |number| number.positive? && number <= 6 }
    end
    combo
  end

  def guess_combo(*)
    combo_input
  end

  def define_secret
    puts 'Choose your secret combination.'
    combo_input
  end

  def give_feedback(secret, guess)
    puts "Your secret combo: #{secret}\nCodebreaker's guess: #{guess}"
    valid_entry = false
    until valid_entry
      puts 'Enter number of pegs of the correct value and correct position (0-4),'\
      ' and the number of pegs of the correct value but in the wrong position (0-4)'
      feedback = gets.chomp.split('').map(&:to_i)
      valid_entry =
        (feedback.length == 2) && feedback.all? { |number| number >= 0 && number <= 4 }
    end
    feedback
  end
end

# Specifics for AI player
class Computer < Player
  def new_game
    # Create the list 1111,...,6666 of all candidate secret codes
    guess_list_temp = (1111..6666).map { |n| n.to_s.split('').map(&:to_i) }
    @guess_list = guess_list_temp.filter { |combo| combo.none?(0) } # removes all combos including 0
    @first_guess = true
  end

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

  def guess_combo(last_guess, last_feedback)
    if @first_guess
      @first_guess = false
      [1, 1, 2, 2]
    else
      @guess_list = @guess_list.filter { |ans| last_feedback == give_feedback(ans, last_guess) }
      @guess_list[0]
    end
  end
end
