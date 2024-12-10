# lines = """1000
# 2000
# 3000

# 4000

# 5000
# 6000

# 7000
# 8000
# 9000

# 10000
# """.split("\n")
##########
# Part 1 #
##########

lines = File.readlines("2022/day1/input.txt").map(&:chomp)

elves_rations = lines.slice_before { |line| line.empty? }.map do |group|
  group.map(&:to_i)
end

puts "Highest calorie elf: #{elves_rations.map(&:sum).max}"

##########
# Part 2 #
##########

# Sum and sort to get top 3 highest calorie elves
top_3_total = elves_rations.map(&:sum).max(3).sum
puts "Top 3 elves: #{top_3_total}"
