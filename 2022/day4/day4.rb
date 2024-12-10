lines = File.read('2022/day4/input.txt').split("\n")

##########
# Part 1 #
##########

pairs = []

lines.each do |line|
  pairs << line.split(',').map { |pair| pair.split('-').map(&:to_i) }
end

pairs.each do |pair|
  pair.each do |pair_set|
    if pair_set[0] <= pair_set[1]
      for i in pair_set[0]..pair_set[1]
        pair_set << i
      end
    else
      for i in pair_set[1]..pair_set[0]
        pair_set << i
      end
    end
    pair_set.uniq!
  end
end

part_one = 0
pairs.each do |pair|
  if pair[0].all? { |num| pair[1].include?(num) } || pair[1].all? { |num| pair[0].include?(num) }
  part_one += 1
  end
end

puts "Part 1: #{part_one}"

##########
# Part 2 #
##########

part_two = 0
pairs.each do |pair|
  if pair[0].any? { |num| pair[1].include?(num) }
  part_two += 1
  end
end
puts "Part 2: #{part_two}"