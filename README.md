# Mastermind

Mastermind in Ruby for [The Odin Project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/mastermind)

## Game Elements

### Decoding board
- 12 rows of 4 large holes (codes) and 4 smaller holes (clues)

### Code pegs
- 6 different colors (1 to 6)
- Will be placed on the decoding board

### Key pegs
- black: correct color and position
- white: correct color
- blank: incorrect color or position

### Players
2 players alternate as **codemaker** and **codebreaker**
####  Codemaker
Choses a pattern of four code pegs. Blanks and duplicates may be allowed.
Each guess is responded with the key pegs.
The codemaker gets **one point for each guess the codebreaker makes**. **An extra point** is earned by the codemaker if the codebreaker is **unable to guess the exact pattern within the given number of turns**.

#### Codebreaker
Makes a guess combination each round.

### Rounds
12 rounds
Guesses and feedback alternate until end of rounds.

### End of game
When the codebreaker finds the right combination (codebreaker wins) or all the rows on the decoding board are full.

## Methods used

### Feedback algorithm
*From [Stack Overflow](https://stackoverflow.com/a/2005930)*

Knuth answers this in [The Computer as Master Mind](https://www.cs.uni.edu/~wallingf/teaching/cs3530/resources/knuth-mastermind.pdf) and acknowledges that it's hard to define it exactly. He suggests this:
1. Calculate the number of blacks by comparing each position in the answer with the same position in the current guess.
2. Calculate the number of whites plus blacks as below.
3. Subtract (1) from (2) to get the number of whites.

To calculate whites plus blacks:

1. Make two arrays, `ans` and `guess`, with a slot for each color.
2. For each color, populate `ans` with the number of pegs of that color in the answer. Similarly, populate `guess` with the number of pegs of that color in the current guess.
3. Add up `min(ans[i], guess[i])` for each i. This is whites plus blacks. (`[ans[i], guess[i]].min` in Ruby).

### Swaszek Strategy
1. Create the list 1111,...,6666 of all candidate secret codes
2. Start with 1122.
3. Repeat the following 2 steps:
	1. After you got the answer (number of red and number of white pegs) eliminate from the list of candidates all codes that would not have produced the same answer if they were the secret code.
	1. Pick the first element in the list and use it as new guess.

This averages no more than 5 guesses.
