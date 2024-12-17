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

