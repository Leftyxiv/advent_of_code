input = File.read('2022/day5/sample.txt')# .split("\n\n")

columns = Array.new(9) { [] }

lines = input.split("\n\n").reverse.drop(1)
puts lines.inspect
number_of_columns = lines.last.scan(/\[\w\]/).length
puts lines.last.scan(/\[\w\]/).inspect, '----------'
columns = Array.new(number_of_columns) { [] }

lines.each do |line|
  (0...number_of_columns).each do |i|
    char_index = 1 + i * 4 # Calculate index based on column offset
    puts  "char_index: #{char_index}"
    columns[i] << line[char_index] if line[char_index] =~ /[A-Z]/
  end
end

# lines.each do |line|
#   columns[0] << line[1] if line[1] =~ /[A-Z]/
#   columns[1] << line[5] if line[5] =~ /[A-Z]/
#   columns[2] << line[9] if line[9] =~ /[A-Z]/
# end

instructions = input.split("\n\n")[1]

movement_tuples = instructions.lines.map do |line|
  match_data = line.match(/move (\d+) from (\d+) to (\d+)/)
  [match_data[1].to_i, match_data[2].to_i, match_data[3].to_i] if match_data
end

part_one = ''

movement_tuples.each do |tuple|
  tuple[0].times do
    puts "tuple: #{tuple}"
    puts columns.inspect
    #columns[tuple[2] - 1] << columns[tuple[1] - 1].pop if columns[tuple[1] - 1][-1]
  end
end
columns.each do |column|
 # part_one += column[-1] if column[-1]
end
puts "Part 1: #{part_one}"