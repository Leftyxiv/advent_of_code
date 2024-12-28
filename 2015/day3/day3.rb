line = File.read('2015/day3/input.txt')

houses = [[0, 0]]
santa = [0, 0]
robo_santa = [0, 0]

directions = {
  '^' => [-1, 0],
  'v' => [1, 0],
  '<' => [0, -1],
  '>' => [0, 1]
}

line.each_char do |char|
  santa = santa.zip(directions[char]).map(&:sum)
  houses << santa
end

puts "Part 1: #{houses.uniq.count}"
houses = [[0, 0]]
line.each_char.with_index do |char, i|
  if i.even?
    santa = santa.zip(directions[char]).map(&:sum)
    next if houses.include?(santa)
    houses << santa
  else
    robo_santa = robo_santa.zip(directions[char]).map(&:sum)
    next if houses.include?(robo_santa)
    houses << robo_santa
  end
end

puts "Part 2: #{houses.uniq.count}"