input = File.read('2022/day5/input.txt')# .split("\n\n")

columns = Array.new(8) { [] }

lines = input.split("\n").reverse.drop(1)

lines.each do |line|
  columns[0] << line[1] if line[1] =~ /[A-Z]/
  columns[1] << line[5] if line[5] =~ /[A-Z]/
  columns[2] << line[9] if line[9] =~ /[A-Z]/
end

instructions = input.split("\n\n")[1]

movement_tuples = instructions.lines.map do |line|
  match_data = line.match(/move (\d+) from (\d+) to (\d+)/)
  [match_data[1].to_i, match_data[2].to_i, match_data[3].to_i] if match_data
end

part_one = ''

movement_tuples.each do |tuple|
  tuple[0].times do
    columns[tuple[2] - 1] << columns[tuple[1] - 1].pop
  end
end
columns.each do |column|
  part_one += column[-1] if column[-1]
end
puts "Part 1: #{part_one}"