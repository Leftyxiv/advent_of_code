lines = File.readlines('2025/day3/input.txt').map(&:chomp)

##########
# Part 1 #
##########

part_one = 0

# lines.each do |line|
#   joltages << line
#   nums = line.split('').map(&:to_i)
#   max_joltage_locations << [nums[0..-2].max, nums[0..-2].each_index.select { |i| nums[i] == nums[0..-2].max }]
# end

lines.each do |line|
  numbaz = line.split('').map(&:to_i)[0..-2]
  all_numbaz = line.split('').map(&:to_i)
  max_joltage = numbaz.max
  max_index = numbaz.index(max_joltage)
  remaining_numbaz = all_numbaz[(max_index + 1)..]
  next_numba = remaining_numbaz.max
  part_one += (max_joltage.to_s + next_numba.to_s).to_i
end

puts "Part 1: #{part_one}"

##########
# Part 2 #
##########

def get_me_that_digit_bro(digits, n)
  return '' if digits.empty? || n == 0

  window = digits[0..(digits.length - n)]
  max_numba = window.max
  max_index = window.index(max_numba)
  
  max_numba.to_s + get_me_that_digit_bro(digits[(max_index + 1)..], n - 1)
end

part_two = 0

lines.each do |line|
  part_two += get_me_that_digit_bro(line.split('').map(&:to_i), 12).to_i
end

puts "Part 2: #{part_two}"

##########
# Part 1 part 2 #
##########

part_one_part_two = 0

lines.each do |line|
  part_one_part_two += get_me_that_digit_bro(line.split('').map(&:to_i), 2).to_i
end

puts "Part 1v2: #{part_one_part_two}"