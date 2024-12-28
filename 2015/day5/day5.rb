lines = File.read('2015/day5/input.txt').split("\n")

vowel_matcher = /[aeiou]/
double_matcher = /(.)\1/
naughty_matcher = /ab|cd|pq|xy/

nice_strings = 0
lines.each do |line|
  next if line.match?(naughty_matcher)
  next unless line.scan(vowel_matcher).count >= 3
  next unless line.match?(double_matcher)

  nice_strings += 1
end
puts "Part 1: #{nice_strings}"

part_two_nice_strings = 0
part_two_double_matcher = /(..).*\1/
part_two_letter_matcher = /(.).\1/
lines.each do |line|
  next unless line.match?(part_two_double_matcher)
  next unless line.match?(part_two_letter_matcher)

  part_two_nice_strings += 1
end
puts "Part 2: #{part_two_nice_strings}"