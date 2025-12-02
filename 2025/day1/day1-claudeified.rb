DIAL_SIZE = 100

def parse_instruction(line)
  direction = line[0]
  spaces = line[1..].to_i
  [direction, spaces]
end

def move_dial(position, direction, spaces)
  delta = direction == 'L' ? -spaces : spaces
  (position + delta) % DIAL_SIZE
end

def count_zero_crossings(start_pos, end_pos, direction, spaces)
  crossings = spaces / DIAL_SIZE

  if direction == 'L'
    crossings += 1 if end_pos > start_pos && start_pos != 0
  else
    crossings += 1 if end_pos < start_pos && end_pos != 0
  end

  crossings
end

lines = File.read('2025/day1/input.txt').split("\n")

# Part 1: Count times we land on 0
position = 50
zero_landings = lines.count do |line|
  direction, spaces = parse_instruction(line)
  position = move_dial(position, direction, spaces)
  position == 0
end

puts "step 1: #{zero_landings}"

# Part 2: Count times we cross or land on 0
position = 50
zero_crossings = 0

lines.each do |line|
  direction, spaces = parse_instruction(line)
  new_position = move_dial(position, direction, spaces)

  zero_crossings += count_zero_crossings(position, new_position, direction, spaces)
  zero_crossings += 1 if new_position == 0

  position = new_position
end

puts "step 2: #{zero_crossings}"
