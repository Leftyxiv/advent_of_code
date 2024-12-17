require_relative '../../utils/griderator'
require 'set'
lines = File.read("2024/day15/sample2.txt").split("\n\n")

map, directions = lines[0].split("\n"), lines[1].split('')

grid = Griderator5000.new(map)

super_broken_robot = grid.find_location('@')

DIRECTIONS = {
  :'^' => [-1, 0],
  :'v' => [1, 0],
  :'<' => [0, -1],
  :'>' => [0, 1]
}

def move_robot(grid, robot, direction)
  boxes = []
  row, col = robot
  dr, dc = direction
  return robot if grid[row + dr, col + dc] == '#'

  if grid[row + dr, col + dc] == '.'
    grid[row, col] = '.'
    grid[row + dr, col + dc] = '@'
    return [row + dr, col + dc]
  end

  while grid[row + dr, col + dc] != '#' && grid[row + dr, col + dc] != '.' do
    row += dr
    col += dc
    if grid[row, col] == 'O'
      boxes << [row, col]
    end
  end
  return robot if grid[row + dr, col + dc] == '#'
  row += dr
  col += dc
  grid[row, col] = 'O'
  boxes.each do |box|
    grid[box[0], box[1]] = 'O'
  end
  grid[boxes.first[0], boxes.first[1]] = '@'
  grid[robot[0], robot[1]] = '.'
  return boxes.first
end

##########
# Part 1 #
##########

part_one = 0

directions.each do |direction|
  next if direction == "\n"
  super_broken_robot = move_robot(grid, super_broken_robot, DIRECTIONS[direction.to_sym])
end

box_locations = grid.find_all_locations('O')

def move_fat_robot(grid, robot, direction)
  row, col = robot
  begrow, begcol = robot
  dr, dc = direction
  return robot if grid[row + dr, col + dc] == '#'

  if grid[row + dr, col + dc] == '.'
    grid[row, col] = '.'
    grid[row + dr, col + dc] = '@'
    return [row + dr, col + dc]
  end

  if dc != 0
    while grid[row + dr, col + dc] != '.' do
      return robot if grid[row + dr, col + dc] == '#'

      col += dc
    end
    col += dc
    while col != begcol do
      grid[row, col] = grid[row, col - dc]
      col -= dc
    end
    grid[row, col] = '.'
  end

  if dr != 0

    found_boxes = find_and_follow_boxes(grid, row + dr, col + dc, direction)
    return robot if found_boxes.include?(nil)

    found_boxes.reverse.each do |box|
      puts box.inspect
        grid[box[0] + dr, box[1] + dc] = grid[box[0], box[1]]
        grid[box[0], box[1]] = '.'
    end
  end

  grid[begrow, begcol] = '.'
  grid[row + dr, col + dc] = '@'
  [row + dr, col + dc]
end

box_locations.each do |box|
  x, y = box
  part_one += 100 * x + y
end
puts "Part 1: #{part_one}"

##########
# Part 2 #
##########

wider_map = []
map.each do |row|
  new_row = ''
  row.each_char do |char|
    if char == '#'
      new_row += '##'
    elsif char == '.'
    new_row += '..'
    elsif char == 'O'
      new_row += '[]'
    elsif char == '@'
      new_row += '@.'
    end
  end
  wider_map << new_row
end

fat_grid = Griderator5000.new(wider_map)

def move_fat_robot(grid, robot, direction)
  row, col = robot
  begrow, begcol = robot
  dr, dc = direction
  return robot if grid[row + dr, col + dc] == '#'

  if grid[row + dr, col + dc] == '.'
    grid[row, col] = '.'
    grid[row + dr, col + dc] = '@'
    return [row + dr, col + dc]
  end

  if dc != 0
    while grid[row + dr, col + dc] != '.' do
      return robot if grid[row + dr, col + dc] == '#'

      col += dc
    end
    col += dc
    while col != begcol do
      grid[row, col] = grid[row, col - dc]
      col -= dc
    end
    grid[row, col] = '.'
  end

  if dr != 0
    stop_ruining_my_life = these_god_forsaken_vertical_boxes(grid, row + dr, col, direction)
    
    found_boxes = find_and_follow_boxes(grid, row + dr, col + dc, direction)
    return robot if found_boxes.include?(nil)

    found_boxes.reverse.each do |box|
        grid[box[0] + dr, box[1] + dc] = grid[box[0], box[1]]
        grid[box[0], box[1]] = '.'
    end
  end

  grid[begrow, begcol] = '.'
  grid[row + dr, col + dc] = '@'
  [row + dr, col + dc]
end

def these_god_forsaken_vertical_boxes(grid, row, col, direction)
  drow, dcol = direction
  boxes = []
  is_this_side = false
  while grid[row + drow, col] == '[' && grid[row + drow, col + 1] == ']' do
    boxes << [row + drow, col]
    boxes << [row + drow, col + 1]
    row += drow
    is_this_side = true
  end
  boxes << [row + drow, col] if is_this_side
  boxes << [row + drow, col + 1] if is_this_side
  unless grid[row + drow, col] == '.' && grid[row + drow, col + 1] == '.' && is_this_side
    return boxes << nil
  end
  if grid[row + drow, col] == '.' && grid[row + drow, col + 1] == '.' && is_this_side
    return boxes
  end

  while grid[row + drow, col] == ']' && grid[row + drow, col - 1] == '[' do
    boxes << [row + drow, col - 1]
    boxes << [row + drow, col]
    row += drow
  end
  boxes << [row + drow, col - 1] unless is_this_side
  boxes << [row + drow, col] unless is_this_side
  unless grid[row + drow, col] == '.' && grid[row + drow, col - 1] == '.' && !is_this_side
    return boxes << nil
  end
  boxes
end

# def find_and_follow_boxes(grid, row, col, velocity, visited = Set.new)
#   dr, dc = velocity
#   current_pos = [row, col]

#   return [] if visited.include?(current_pos)
#   visited.add(current_pos)

#   found_boxes = []

#   if grid[row, col] == '[' && grid[row, col + 1] == ']'
#     found_boxes << current_pos
#     found_boxes << [row, col + 1]
#     if grid[row + dr, col] != '#' && grid[row + dr, col + 1] != '#'
#       above_boxes = find_and_follow_boxes(grid, row + dr, col, velocity, visited)
#       return [nil] if above_boxes.include?(nil)
#       found_boxes.concat(above_boxes)
#     else
#       return [nil]
#     end
#   elsif grid[row, col] == ']' && grid[row, col - 1] == '['
#     found_boxes << [row, col - 1]
#     found_boxes << current_pos
#     if grid[row + dr, col - 1] != '#' && grid[row + dr, col] != '#'
#       above_boxes = find_and_follow_boxes(grid, row + dr, col - 1, velocity, visited)
#       return [nil] if above_boxes.include?(nil)
#       found_boxes.concat(above_boxes)
#     else
#       return [nil]
#     end
#   elsif grid[row, col] == '#'
#     return [nil]
#   end

#   found_boxes
# end
def find_and_follow_boxes(grid, row, col, velocity, visited = Set.new)
  dr, dc = velocity
  current_pos = [row, col]

  visited.add(current_pos)

  found_boxes = []

  if grid[row, col] == '[' && grid[row, col + 1] == ']'
    found_boxes << current_pos
    found_boxes << [row, col + 1]
    found_boxes.concat(find_and_follow_boxes(grid, row + dr, col, velocity, visited))
    found_boxes.concat(find_and_follow_boxes(grid, row + dr, col + 1, velocity, visited))
  elsif grid[row, col] == ']' && grid[row, col - 1] == '['
    found_boxes << [row, col - 1]
    found_boxes << current_pos
    found_boxes.concat(find_and_follow_boxes(grid, row + dr, col - 1, velocity, visited))
    found_boxes.concat(find_and_follow_boxes(grid, row + dr, col, velocity, visited))
  elsif grid[row, col] == '#' || grid[row, col + 1] == '#' || grid[row, col - 1] == '#'
    found_boxes << nil
  end

  found_boxes
end

part_two = 0
fat_super_broken_robot = fat_grid.find_location('@')
directions.each do |direction|
  next if direction == "\n"
  puts "Moving #{direction}"
  fat_super_broken_robot = move_fat_robot(fat_grid, fat_super_broken_robot, DIRECTIONS[direction.to_sym])
  fat_grid.grid_me
end

box_corners = fat_grid.find_all_locations('[')

box_corners.each do |box|
  x, y = box
  part_two += 100 * x + y
end
fat_grid.grid_me

puts "Part 2: #{part_two}"

# def find_and_follow_boxes(grid, row, col, velocity, visited = Set.new)
#   dr, dc = velocity
#   return [] if visited.include?([row, col])  # To prevent infinite loops

#   visited.add([row, col])
#   found_boxes = []

#   if grid[row, col] == '[' && grid[row, col + 1] == ']'
#     found_boxes << [row, col]
#     found_boxes << [row, col + 1]
#     if grid[row + dr, col] == '[' && grid[row + dr, col + 1] == ']'
#       found_boxes.concat(find_and_follow_boxes(grid, row + dr, col, velocity, visited))
#     end
#   elsif grid[row, col] == ']' && grid[row, col - 1] == '['
#     found_boxes << [row, col - 1]
#     found_boxes << [row, col]
#     if grid[row + dr, col] == ']' && grid[row + dr, col - 1] == '['
#       found_boxes.concat(find_and_follow_boxes(grid, row + dr, col - 1, velocity, visited))
#     end
#   end

#   if grid[row + dr, col] == '#' || grid[row + dr, col + 1] == '#'
#     return [nil]
#   end

#   found_boxes
# end
