input = File.read('2025/day2/input.txt').split("\n").map { |line| line.split(',').map { |range| range.split('-').map(&:to_i) } }[0]

##########
# Part 1 #
##########

part_one = 0
part_two = 0
pattern = Regexp.new('^(\d+)\1$')
part_two_pattern = Regexp.new('^(\d+)\1+$')

input.each do |range|
  (range[0].to_i..range[1].to_i).each do |num|
    if pattern.match?(num.to_s)
      part_one += num.to_i
    end
    if part_two_pattern.match?(num.to_s)
      part_two += num.to_i
      # puts num.to_s.inspect
    end
  end
end

puts "Part 1: #{part_one}"
puts "Part 2: #{part_two}"