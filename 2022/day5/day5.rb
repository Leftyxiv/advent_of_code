boxes, movements = File.read('2022/day5/input.txt').split("\n\n")

##########
# Part 1 #
##########

boxes = boxes.split("\n").reverse
stack_locations = {}
boxes[0].each_char.with_index do |char, index|
  if char != ' '
    stack_locations[index] = []
  end
end

boxes[1..-1].each do |box|
  stack_locations.each do |location, arr|
    stack_locations[location] << (box[location]) if box[location] != ' '
  end
end

movement_tuples = movements.lines.map do |line|
  match_data = line.match(/move (\d+) from (\d+) to (\d+)/)
  [match_data[1].to_i, match_data[2].to_i, match_data[3].to_i] if match_data
end

stack_map = {}

i = 1
stack_locations.each do |location, arr|
  new_arr = []
  until arr.empty?
    new_arr << arr.pop
  end
  stack_map[i] = new_arr.reverse
  i += 1
end

part_two_stax = Marshal.load(Marshal.dump(stack_map))

movement_tuples.each do |tuple|
  tuple[0].times do
    char_to_move = stack_map[tuple[1]].pop
    stack_map[tuple[2]] << char_to_move
  end
end

part_one = ''

stack_map.each do |_, arr|
  part_one += arr[-1] if arr[-1]
end

puts "Part 1: #{part_one}"

##########
# Part 2 #
####@#####
part_two = ''
movement_tuples.each do |tuple|
  new_stack_method = ''
  tuple[0].times do
    char_to_move = part_two_stax[tuple[1]].pop
    new_stack_method += char_to_move
  end
  new_stack_method.reverse!
  new_stack_method.each_char do |char|
    part_two_stax[tuple[2]] << char
  end
end
part_one = ''

part_two_stax.each do |_, arr|
  part_two += arr[-1] if arr[-1]
end

puts "Part 1: #{part_two}"