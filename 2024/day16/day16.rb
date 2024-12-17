require_relative '../../utils/griderator'
require 'set'
require 'pqueue'

lines = File.read('2024/day16/input.txt').split("\n")
grid = Griderator5000.new(lines)

starting_point = grid.find_location('S')
end_point = grid.find_location('E')

DIRECTIONS = {
  '^' => [-1, 0],
  'v' => [1, 0],
  '<' => [0, -1],
  '>' => [0, 1]
}

def turn_left(direction)
  { '^' => '<', '>' => '^', 'v' => '>', '<' => 'v' }[direction]
end

def turn_right(direction)
  { '^' => '>', '>' => 'v', 'v' => '<', '<' => '^' }[direction]
end

def move_forward(location, direction)
  row, col = location
  vx, vy = DIRECTIONS[direction]
  [row + vx, col + vy]
end

def manhattan_distance(a, b)
  (a[0] - b[0]).abs + (a[1] - b[1]).abs
end


def go_reindeer_go(grid, start, end_point)
  queue = PQueue.new([[start, '>', 0, 0]]) { |a, b| a[2] + a[3] < b[2] + b[3] }
  visited = Set.new
  
  while !queue.empty?
    location, direction, score, turns = queue.pop
    
    if location == end_point
      return score
    end
    
    state = [location, direction]
    next if visited.include?(state)
    visited.add(state)

    next_location = move_forward(location, direction)
    if grid.in_bounds?(*next_location) && grid[*next_location] != '#'
      queue.push([next_location, direction, score + 1, turns, manhattan_distance(next_location, end_point)])
    end

    left_direction = turn_left(direction)
    queue.push([location, left_direction, score + 1000, turns + 1, manhattan_distance(location, end_point)])

    right_direction = turn_right(direction)
    queue.push([location, right_direction, score + 1000, turns + 1, manhattan_distance(location, end_point)])
  end
  
  Float::INFINITY
end


least_stuff_trampled = go_reindeer_go(grid, starting_point, end_point)
puts "Part 1: #{least_stuff_trampled}"

def find_best_path_tiles(grid, start, end_point, best_score)
  queue = [[start, '>', 0, Set.new([start])]]
  best_path_tiles = Set.new
  state_visited = 0
  
  while !queue.empty?
    state_visited += 1
    puts "States visited: #{state_visited}" if state_visited % 100_000 == 0
    location, direction, score, path = queue.shift
    
    if score > best_score
      next
    end
    
    if location == end_point && score == best_score
      best_path_tiles.merge(path)
      next
    end

    next_location = move_forward(location, direction)
    if grid.in_bounds?(*next_location) && grid[*next_location] != '#'
      new_path = path.dup.add(next_location)
      queue.push([next_location, direction, score + 1, new_path])
    end

    left_direction = turn_left(direction)
    queue.push([location, left_direction, score + 1000, path])

    right_direction = turn_right(direction)
    queue.push([location, right_direction, score + 1000, path])
  end
  
  best_path_tiles
end


best_path_tiles = find_best_path_tiles(grid, starting_point, end_point, least_stuff_trampled)
puts "Part 2: #{best_path_tiles.size}"

# def flip_direction(direction)
#   { '^' => 'v', 'v' => '^', '<' => '>', '>' => '<' }[direction]
# end

# def find_best_path_tiles(grid, start, end_point)
#   best_score, from_start = go_reindeer_go(grid, start, end_point)
  
#   # Run Dijkstra from end point in all four directions
#   from_end = {}
#   ['>', '<', '^', 'v'].each do |dir|
#     _, distances = go_reindeer_go(grid, end_point, start)
#     distances.each do |state, score|
#       location, direction = state
#       from_end[[location, flip_direction(direction)]] = score
#     end
#   end
  
#   best_path_tiles = Set.new
  
#   grid.each_cell do |row, col, _|
#     ['>', '<', '^', 'v'].each do |dir|
#       forward_score = from_start[[row, col], dir] || Float::INFINITY
#       backward_score = from_end[[row, col], dir] || Float::INFINITY
      
#       if forward_score + backward_score == best_score
#         best_path_tiles.add([row, col])
#       end
#     end
#   end
  
#   [best_score, best_path_tiles]
# end

# _, best_path_tiles = find_best_path_tiles(grid, starting_point, end_point)
# puts "Part 2: #{best_path_tiles.size}"

# def find_best_paths(grid, start, end_point)
#   queue = PQueue.new([[0, start, '>', 0, Set.new([start])]]) { |a, b| a[0] < b[0] }
#   best_score = Float::INFINITY
#   best_path_tiles = Set.new
#   visited = Hash.new { |h, k| h[k] = Float::INFINITY }
#   states_explored = 0

#   while !queue.empty?
#     states_explored += 1
#     if states_explored % 1_000_000 == 0
#       puts "Explored #{states_explored} states. Queue size: #{queue.size}"
#     end

#     f_score, location, direction, g_score, path = queue.pop
#     row, col = location

#     if g_score > best_score
#       next
#     end

#     if location == end_point
#       if g_score < best_score
#         best_score = g_score
#         best_path_tiles = path
#       elsif g_score == best_score
#         best_path_tiles.merge(path)
#       end
#       next
#     end

#     state = [location, direction]
#     next if visited[state] <= g_score
#     visited[state] = g_score

#     [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dr, dc|
#       new_row, new_col = row + dr, col + dc
#       next_location = [new_row, new_col]

#       if grid.in_bounds?(new_row, new_col) && grid[new_row, new_col] != '#'
#         new_direction = DIRECTIONS.key([dr, dc])
#         turn_cost = (new_direction == direction) ? 0 : 1000
#         new_g_score = g_score + 1 + turn_cost
#         new_path = path.dup.add(next_location)
#         h_score = manhattan_distance(next_location, end_point)
#         f_score = new_g_score + h_score

#         queue.push([f_score, next_location, new_direction, new_g_score, new_path])
#       end
#     end
#   end

#   [best_score, best_path_tiles]
# end


# def find_best_path_tiles(grid, start, end_point, best_score)
#   queue = [[start, '>', 0, Set.new([start])]]
#   best_path_tiles = Set.new
#   states_visited = 0
  
#   while !queue.empty?
#     states_visited += 1
#     puts "States visited: #{states_visited}" if states_visited % 100_000 == 0
#     location, direction, score, path = queue.shift
    
#     if score > best_score
#       next
#     end
    
#     if location == end_point && score == best_score
#       best_path_tiles.merge(path)
#       next
#     end

#     next_location = move_forward(location, direction)
#     if grid.in_bounds?(*next_location) && grid[*next_location] != '#'
#       new_path = path.dup.add(next_location)
#       queue.push([next_location, direction, score + 1, new_path])
#     end

#     left_direction = turn_left(direction)
#     queue.push([location, left_direction, score + 1000, path])

#     right_direction = turn_right(direction)
#     queue.push([location, right_direction, score + 1000, path])
#   end
  
#   best_path_tiles
# end
# best_path_tiles = find_best_path_tiles(grid, starting_point, end_point, least_stuff_trampled)
# puts "Part 2: #{best_path_tiles.size}"
