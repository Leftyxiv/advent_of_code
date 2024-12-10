pipe_map = File.readlines('sample2.txt').map(&:chomp)

# Find start position
start = pipe_map.flat_map.with_index { |row, y| row.chars.map.with_index { |char, x| [y, x] if char == 'S' } }.compact.first

pipes = {}
pipes[start] = 0

queue = [start]

# Define movement directions
directions = [[-1, 0], [0, 1], [1, 0], [0, -1]] # North, East, South, West
direction_names = %w(| - | -)
direction_bends = %w(L J F 7)

# BFS Loop to find all pipes in the main loop
until queue.empty?
  current = queue.shift
  
  current_pipe = pipe_map[current.first][current.last]
  if current_pipe == 'S'
    current_directions = directions.select.with_index do |direction, i|
      y, x = current.first + direction.first, current.last + direction.last
      next if y < 0 || x < 0 || y >= pipe_map.size || x >= pipe_map.first.size
      neighbor = pipe_map[y][x]
      neighbor != '.' &&
        (neighbor == direction_names[i] ||
        neighbor == direction_bends[i % 2] ||
        neighbor == direction_bends[(i + 3) % 4])
    end
  else
    current_directions = directions.select.with_index { |_direction, i| current_pipe == direction_names[i] || current_pipe == direction_bends[i % 2] || current_pipe == direction_bends[(i + 3) % 4] }
  end
  
  current_directions.each do |direction|
    new_point = [current.first + direction.first, current.last + direction.last]
    next if new_point.first < 0 || new_point.first >= pipe_map.size || new_point.last < 0 || new_point.last >= pipe_map.first.size
    new_pipe = pipe_map[new_point.first][new_point.last]
    
    if new_pipe != '.' && !pipes[new_point]
      pipes[new_point] = pipes[current] + 1
      queue.push new_point
    end
  end
end

# Find the farthest point from the start
max_steps = pipes.values.max
puts "The furthest point from S in the loop has #{max_steps} steps."
# Read the map pipe from file
# pipe_map = File.readlines("pipe_map.txt").map(&:chomp)

# Find start position 
# start = pipe_map.flat_map.with_index{|row, y| row.chars.map.with_index{|char, x| [y, x] if char == 'S'}}.compact.first

# # A hash where we store discovered pipes with their distance from the start
# pipes = {}
# pipes[start] = 0

# # A queue for BFS
# queue = [start]

# # Directions to check for adjacent pipes for each type of pipe
# directions = {'|' => [[-1,0], [1, 0]], '-' => [[0, -1], [0, 1]], 'L' => [[-1, 0], [0, 1]], 
#               'J' => [[-1, 0], [0, -1]], '7' => [[1, 0], [0, -1]], 'F' => [[1, 0], [0, 1]], 
#               'S' => [[1, 0], [0, 1]]}

# # BFS Loop to find all pipes in the main loop
# until queue.empty?
#   current = queue.shift
#   current_pipe = pipe_map[current.first][current.last]
#   next unless directions[current_pipe]

#   directions[current_pipe].each do |direction|
#     new_point = [current.first + direction.first, current.last + direction.last]
#     new_pipe = pipe_map[new_point.first][new_point.last]
    
#     if new_pipe != '.' && !pipes[new_point]
#       pipes[new_point] = pipes[current] + 1
#       queue.push new_point
#     end
#   end
# end

# # Find the farthest point from the start
# max_steps = pipes.values.max
# puts "The furthest point from S in the loop has #{max_steps} steps."

# def get_next_tile(last_tile_location, next_tile_grid_location, last_tile, grid)
#   x, y = next_tile_grid_location
#   next_tile = grid[x][y]
#   if next_tile == 'F'
#     if last_tile == '-' || last_tile == 'J' || last_tile == '7'
#       return [x + 1, y, 'F']
#     elsif last_tile == '|'
#       return [x, y + 1, 'F']
#     end
#   elsif next_tile == '7'
#     if last_tile == '-' || last_tile == 'L' || last_tile == 'F'
#       return [x + 1, y, '7']
#     elsif last_tile == '|'
#       return [x, y - 1, '7']
#     end
#   elsif next_tile == 'J'
#     if last_tile == '-' || last_tile == 'F' ||
#       return [x - 1, y, 'J']
#     elsif last_tile == '|'
#       return [x, y - 1, 'J']
#     end
#   elsif next_tile == '-'
#     if last_tile == 'J' || last_tile == '7'
#       return [x - 1, y, '-']
#     elsif last_tile == 'L' || last_tile == 'F'
#       return [x, y + 1, '-']
#     elsif last_tile == '-'
#       last_tile_location[0] < next_tile_grid_location[0] ? [x + 1, y, '-'] : [x - 1, y, '-']
#     end
#   elsif next_tile == '|'
#     if last_tile == 'J'
#       return [x - 1, y, '|']
#     elsif last_tile == 'F' || last_tile == 'L'
#       return [x, y + 1, '|']
#     elsif 

#     end
#   end
# end