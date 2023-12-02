lines = File.read('input.txt').split("\n")

##########
# Part 1 #
##########

total = 0
lines.each do |line|
  # Let's try removing the letters form the lines.
  line_without_letters = line.gsub(/\D/, '')

  # We are only concerned with the first and the last digits.
  first_digit = line_without_letters[0]
  last_digit = line_without_letters[-1]

  total += [first_digit, last_digit].join.to_i
end

puts "Part 2: #{total}"

##########
# Part 2 #
##########

# Let's use a map to understand which words map to which digits. The word "zero" isn't mentioned, so let's ignore for now.
WORD_MAP = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9,
}

total = 0
lines.each do |line|
  # How do we get the first digit and the last digit now??

  # We have to take into account both numbers as words ("one", "two", "three") and 0-9.

  # For the first digit, let's try to take subsequent substrings of the line, and see if they begin with either the words or the actual digits.
  first_digit = nil
  (0..(line.length - 1)).each do |i|
    substring = line[i..]

    if /[0-9]/ =~ substring[0]
      first_digit = substring[0].to_i
    else
      WORD_MAP.each do |k, v|
        if substring.start_with?(k)
          first_digit = v
          break
        end
      end
    end

    if first_digit
      break
    end
  end

  # For the last digit, we can take the same approach, just reverse both the string and the map key.
  last_digit = nil
  reversed_line = line.reverse
  (0..(reversed_line.length - 1)).each do |i|
    substring = reversed_line[i..]

    if /[0-9]/ =~ substring[0]
      last_digit = substring[0].to_i
    else
      WORD_MAP.each do |k, v|
        if substring.start_with?(k.reverse)
          last_digit = v
          break
        end
      end
    end

    if last_digit
      break
    end
  end

  total += [first_digit, last_digit].join.to_i
end

puts "Part 2: #{total}"