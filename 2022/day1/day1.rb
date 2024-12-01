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
elves_rations = []
index = 0
lines.each do |line|
  if line.empty?
    index += 1
    next
  end
  elves_rations[index] ||= []
  elves_rations[index] << line.to_i
end
puts "Highest calorie else: #{elves_rations.map { |rations| rations.sum }.max}"

##########
# Part 2 #
##########

sorted_elves_rations = elves_rations.map { |rations| rations.sum }.sort.reverse
puts "Top 3 elves: #{sorted_elves_rations[0..2].sum}"