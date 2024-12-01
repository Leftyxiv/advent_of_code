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

total = 0
left_array = []
right_array = []

lines.each do |line|
  separated_values = line.split(' ')
  left_array << separated_values[0]
  right_array << separated_values[1]
end

left_array.sort!
right_array.sort!

left_array.each_with_index do |left, index|
  right = right_array[index]
  total += (left.to_i - right.to_i).abs
end

puts "Part 1 #{total}"

##########
# Part 2 #
##########

part_two_total = 0

left_array.each do |left|
  samesies = 0
  right_array.each do |right|
    if left == right
      samesies += 1
    end
  end
  part_two_total += left.to_i * samesies
end

puts "Part 2: #{part_two_total}"