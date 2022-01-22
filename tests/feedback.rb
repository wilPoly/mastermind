# frozen_string_literal: true

combo1 = [1, 1, 2, 3]

guess1 = [1, 3, 1, 4] # => [1, 2] BBW
guess2 = [1, 1, 2, 4] # => [3, 0] BBB
guess3 = [1, 1, 3, 3] # => [3, 0] BBB - gives 0 white because the numbers are repeated and one is correct
guess4 = [1, 1, 3, 2] # => [2, 2] BBWW
guess5 = [1, 1, 2, 3] # => "Correct !"
guess6 = [1, 1, 3, 1] # => [2, 1]
guess7 = [1, 1, 1, 1] # => [2, 0]

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

p feedback(combo1, guess1)
p feedback(combo1, guess2)
p feedback(combo1, guess3)
p feedback(combo1, guess4)
p feedback(combo1, guess5)
p feedback(combo1, guess6)
p feedback(combo1, guess7)
