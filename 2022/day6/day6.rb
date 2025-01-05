line = File.read('2022/day6/input.txt')

stream = ''
indy = 0
(3..line.length - 1).each do |char|
  (0..3).each do |i|
    stream += line[char - i]
  end
  if stream.split('').uniq.size == 4
    indy = char
    break
  end
  stream = ''
end
puts "Part 1: #{indy + 1}"

stream = ''
indy = 0
(13..line.length - 1).each do |char|
  (0..13).each do |i|
    stream += line[char - i]
  end
  if stream.split('').uniq.size == 14
    indy = char
    break
  end
  stream = ''
end
puts "Part 2: #{indy + 1}"