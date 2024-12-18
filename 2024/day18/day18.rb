require_relative '../../utils/griderator'
require 'set'

test_mode = false
file = '2024/day18/'
file += test_mode ? 'sample.txt' : 'input.txt'
size = test_mode ? 7 : 71
lines = File.readlines(file, chomp: true)
corrupted_memory_locations = []
## Part 1 ##
if test_mode
  (0..11).each do |i|
    corrupted_memory_locations << lines[i].split(',').map(&:to_i)
  end  
else
  (0..1023).each do |i|
    corrupted_memory_locations << lines[i].split(',').map(&:to_i)
  end  
end

grid =  Griderator5000.new(rows: size, cols: size, default_value: '.')
grid[0, 0] = 'S'
grid[size - 1, size - 1] = 'E'

corrupted_memory_locations.each do |location|
  x, y = location
  grid[y, x] = '#'
end

def run_elves_run(grid)
  start = [0, 0]
  goal = [grid.height - 1, grid.width - 1]
  
  queue = [[start, 0]]
  visited = Set.new
  
  while !queue.empty?
    (current, steps) = queue.min_by { |_, steps| steps }
    queue.delete([current, steps])
    
    return steps if current == goal
    
    if !visited.include?(current)
      visited.add(current)
      
      grid.get_homies(*current).each do |neighbor|
        if !visited.include?(neighbor) && grid[neighbor[0], neighbor[1]] != '#'
          queue << [neighbor, steps + 1]
        end
      end
    end
  end
  
  nil
end

##########
# Part 1 #
##########

steps = run_elves_run(grid)
puts "Part 1: #{steps}"

##########
# Part 2 #
##########

all_corrupted_memory_locations = []

lines.each do |line|
  all_corrupted_memory_locations << line.split(',').map(&:to_i)
end

def find_blocking_byte(corrupted_memory_locations, size)
  grid = Griderator5000.new(rows: size, cols: size, default_value: '.')
  grid[0, 0] = 'S'
  grid[size - 1, size - 1] = 'E'

  corrupted_memory_locations.each_with_index do |location, index|
    x, y = location
    grid[y, x] = '#'
    
    unless run_elves_run(grid)
      return [x, y]
    end
  end

  nil
end

blocking_byte = find_blocking_byte(all_corrupted_memory_locations, size)
puts "Part 2: #{blocking_byte}"