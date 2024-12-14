require_relative '../../utils/griderator'
use_example = false
lines = File.read('2024/day14/sample.txt').split("\n") if use_example
lines = File.read('2024/day14/input.txt').split("\n") unless use_example

dem_bots = {}
i = 0
lines.each do |line|
  match_data = line.match(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/)
  location = [match_data[1].to_i, match_data[2].to_i]
  velocity = [match_data[3].to_i, match_data[4].to_i]
  dem_bots[i] = { location: location, velocity: velocity }
  i += 1
end

rows = use_example ? 7 : 103
cols = use_example ? 11 : 101

def new_location_with_teleport(point, velocity, grid_height, grid_width)
  row, col = point
  vx, vy = velocity

  new_row = row + vx
  new_col = col + vy

  if new_row < 0
    new_row += grid_width
  elsif new_row >= grid_width
    new_row -= grid_width
  end
  
  if new_col < 0
    new_col += grid_height
  elsif new_col >= grid_height
    new_col -= grid_height
  end

  [new_row, new_col]
end

def count_bots_in_quadrants(bots, grid_width, grid_height)
  quadrants = { 1 => 0, 2 => 0, 3 => 0, 4 => 0 }

  midpoint_x = grid_width / 2
  midpoint_y = grid_height / 2

  bots.each do |_id, data|
    x, y = data[:location]
    
    if x < midpoint_x
      if y < midpoint_y
        quadrants[1] += 1
      elsif y > midpoint_y
        quadrants[3] += 1
      end
    elsif x > midpoint_x
      if y < midpoint_y
        quadrants[2] += 1
      elsif y > midpoint_y
        quadrants[4] += 1
      end
    end
  end

  quadrants
end
##########
# Part 1 #
##########

# grid = Griderator5000.new(rows: rows, cols: cols)

dem_bots.each do |bot_id, bot_data|
  location = bot_data[:location]
  100.times do
    location = new_location_with_teleport(location, bot_data[:velocity], rows, cols)
  end
  dem_bots[bot_id][:location] = location
end
quadrants = count_bots_in_quadrants(dem_bots, cols, rows)

puts "Part 1: #{quadrants.values.reduce(:*)}"

##########
# Part 2 #
##########

def has_sequential_bots(bots, required_count = 20)
  position_set = Hash.new { |h, k| h[k] = [] }

  bots.each do |_id, data|
    x, y = data[:location]
    position_set["#{x}x"] << y
    position_set["#{y}y"] << x
  end
  consecutive_count = 0
  full_lines = 0
  position_set.each do |key, values|
    values.sort!
    values.each_with_index do |value, index|
      if index < values.length - 1
        if values[index + 1] - value == 1
          consecutive_count += 1
          if consecutive_count >= required_count
            full_lines += 1
            consecutive_count = 0
            next
          end
        else
          consecutive_count = 0
        end
      end
    end
  end
  full_lines == 4
end
found_this_tree = 101 # starts with 100 seconds elapsed from above + 1 for the 0 in the nxet loop
100_000.times do |i|
  dem_bots.each do |bot_id, bot_data|
    location = bot_data[:location]
    location = new_location_with_teleport(location, bot_data[:velocity], rows, cols)
    dem_bots[bot_id][:location] = location
  end
  if has_sequential_bots(dem_bots, 25)
    found_this_tree += i
    break
  end
end
puts "Part 2: #{found_this_tree}"