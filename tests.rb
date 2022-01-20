# frozen_string_literal: true

combo1 = [1, 1, 2, 3]

guess1 = [1, 1, 3, 4] # => [2, 1] BBW
guess2 = [1, 1, 2, 4] # => [3, 0] BBB
guess3 = [1, 1, 3, 3] # => [3, 0] BBB - gives 0 white because the numbers are repeated and one is correct
guess4 = [1, 1, 3, 2] # => [2, 2] BBWW
guess5 = [1, 1, 2, 3] # => "Correct !"

def feedback(combo, guess)
  feedback = []
  black = 0
  white = 0
  guess.each_with_index do |peg, i|
    if combo[i] == peg
      black += 1
    elsif combo.include?(peg)
      white += 1
    end
  end
  black == 4 ? (puts 'Correct!') : feedback.push(black, white)
end

p feedback(combo1, guess1)
p feedback(combo1, guess2)
p feedback(combo1, guess3)
p feedback(combo1, guess4)
p feedback(combo1, guess5)
