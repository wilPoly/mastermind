# frozen_string_literal: true

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

def human_give_clue
  gets.chomp.split('').map(&:to_i)
end

puts "Secret: #{secret = [3, 6, 5, 2]}"
# Create the list 1111,...,6666 of all candidate secret codes
guess_list_temp = (1111..6666).map { |n| n.to_s.split('').map(&:to_i) }
guess_list = guess_list_temp.filter { |combo| combo.none?(0) } # removes all combos including 0

# Start with 1122.
p guess = [1, 1, 2, 2]
clue = human_give_clue

# Repeat the following 2 steps:
until clue == [4, 0]
  # After you got the answer (number of red and number of white pegs) eliminate from the list of candidates
  # all codes that would not have produced the same answer if they were the secret code.
  guess_list = guess_list.filter { |ans| clue == give_feedback(ans, guess) }
  # Pick the first element in the list and use it as new guess.
  p guess = guess_list[0]
  puts "Secret: #{secret}"
  clue = human_give_clue
end
