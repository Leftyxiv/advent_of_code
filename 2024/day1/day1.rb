# lines = """3   4
# 4   3
# 2   5
# 1   3
# 3   9
# 3   3""".split("\n")
lines = File.read('2024/day1/input.txt').split("\n")

##########
# Part 1 #
##########

left_array, right_array = lines.map { |line| line.split.map(&:to_i) }.transpose

total = left_array.sort.zip(right_array.sort).sum { |left, right| (left - right).abs }

puts "Part 1: #{total}"

##########
# Part 2 #
##########

# Count the occurrences of each value in both arrays
left_counts = left_array.tally
right_counts = right_array.tally

part_two_total = left_counts.sum do |value, left_count|
  (right_counts[value] || 0) * value
end

puts "Part 2: #{part_two_total}"