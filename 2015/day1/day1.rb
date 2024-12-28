line = File.read('2015/day1/input.txt')

total = 0
part_two = []
i = 0
line.each_char do |char|
  total += char == '(' ? 1 : -1
  i += 1
  if total < 0 
    part_two << i
  end
end

puts "Part 1: #{total}"
puts "Part 2: #{part_two.first}"