
  valid_entry = false
  until valid_entry
    puts 'Enter a 4-number combination with numbers from 1 to 6'
    combo = gets.chomp.split("").map { |number| number.to_i }
    valid_entry = 
      (combo.length == 4) && combo.all? { |number| number <= 6 && number.is_a?(Integer) }
  end
  p combo


