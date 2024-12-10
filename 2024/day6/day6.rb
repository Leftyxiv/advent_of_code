require 'set'

# lines = """....#.....
# .........#
# ..........
# ..#.......
# .......#..
# ..........
# .#..^.....
# ........#.
# #.........
# ......#...""".split("\n")
lines = File.read('2024/day6/input.txt').split("\n")


def create_grid(lines)
  grid = []
  lines.each do |line|
    grid << line.split('')
  end
  grid
end

def find_start(grid)
  grid.each_with_index do |line, row|
    line.each_with_index do |char, col|
      return [row, col] if char == '^'
    end
  end
end

def turn_right(direction)
  case direction
    when [0, 1]
      [1,0]
    when [-1, 0]
      [0, 1]
    when [0, -1]
      [-1, 0]
    when [1, 0]
      [0, -1]
  end
end


def move_forward(grid, position, direction, positions_stepped_on_by_elf_lady)
  out_of_bounds = false
  new_x = position[0] + direction[0]
  new_y = position[1] + direction[1]

  if new_x < 0 || new_x >= grid.size || new_y < 0 || new_y >= grid[0].size
    out_of_bounds = true
  elsif grid[new_x][new_y] == '#'
    direction = turn_right(direction)
    new_x = position[0] + direction[0]
    new_y = position[1] + direction[1]

    while grid[new_x][new_y] == '#' do
      direction = turn_right(direction)
      new_x = position[0] + direction[0]
      new_y = position[1] + direction[1]
    end

    if new_x < 0 || new_x >= grid.size || new_y < 0 || new_y >= grid[0].size
      out_of_bounds = true
    else
      position = [new_x, new_y]
    end
  else
    position = [new_x, new_y]
  end

  positions_stepped_on_by_elf_lady << position
  [position, direction, positions_stepped_on_by_elf_lady, out_of_bounds]
end

##########
# Part 1 #
##########

direction = [-1, 0]
grid = create_grid(lines)
position = find_start(grid)
positions_stepped_on_by_elf_lady = []
positions_stepped_on_by_elf_lady << position

loop do
  position, direction, positions_stepped_on_by_elf_lady, out_of_bounds = move_forward(grid, position, direction, positions_stepped_on_by_elf_lady)
  break if out_of_bounds
end

puts "Part 1: #{positions_stepped_on_by_elf_lady.uniq.count}"

##########
# Part 2 #
##########

loopses = 0
start_position = find_start(grid)
initial_path = Set.new(positions_stepped_on_by_elf_lady)

initial_path.each do |pos|
  row, col = pos
  next if grid[row][col] == '#' || pos == start_position

  grid[row][col] = '#'
  position = start_position
  direction = [-1, 0]
  visited_positions_directions = {}
  loop_detected = false

  loop do
    position, direction, _positions_stepped_on, out_of_bounds =
      move_forward(grid, position, direction, [])
    break if out_of_bounds

    key = "#{position}-#{direction}"

    if visited_positions_directions[key]
      loop_detected = true
      break
    end

    visited_positions_directions[key] = true
  end

  loopses += 1 if loop_detected
  grid[row][col] = '.'
end

puts "SO MANY LOOPS: #{loopses}"