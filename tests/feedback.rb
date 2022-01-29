# frozen_string_literal: true

combo1 = [1, 1, 2, 3]

guess1 = [1, 3, 1, 4] # => [1, 2] BBW
guess2 = [1, 1, 2, 4] # => [3, 0] BBB
guess3 = [1, 1, 3, 3] # => [3, 0] BBB - gives 0 white because the numbers are repeated and one is correct
guess4 = [1, 1, 3, 2] # => [2, 2] BBWW
guess5 = [1, 1, 2, 3] # => "Correct !"
guess6 = [1, 1, 3, 1] # => [2, 1]
guess7 = [1, 1, 1, 1] # => [2, 0]

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

p combo1
# feedback(combo1, guess1)
# feedback(combo1, guess2)
# feedback(combo1, guess3)
# feedback(combo1, guess4)
# feedback(combo1, guess5)
# feedback(combo1, guess6)
# feedback(combo1, guess7)

puts "#{count_blacks(combo1, guess1)}, #{count_whites(combo1, guess1)}"
puts "#{count_blacks(combo1, guess2)}, #{count_whites(combo1, guess2)}"
puts "#{count_blacks(combo1, guess3)}, #{count_whites(combo1, guess3)}"
puts "#{count_blacks(combo1, guess4)}, #{count_whites(combo1, guess4)}"
puts "#{count_blacks(combo1, guess5)}, #{count_whites(combo1, guess5)}"
puts "#{count_blacks(combo1, guess6)}, #{count_whites(combo1, guess6)}"
puts "#{count_blacks(combo1, guess7)}, #{count_whites(combo1, guess7)}"
