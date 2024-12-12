require_relative '../../utils/griderator'
require 'set'

lines = File.read('2024/day12/sample3.txt').split("\n")

grid = Griderator5000.new(lines)

def find_connected_components(grid)
  visited = Array.new(grid.height) { Array.new(grid.width, false) }
  components = []

  grid.each_cell do |row, col, cell|
    next if visited[row][col]

    stack = [[row, col]]
    component = []

    while stack.any?
      x, y = stack.pop
      next if visited[x][y]

      visited[x][y] = true
      component << [x, y]

      grid.get_homies(x, y).each do |nx, ny|
        if !visited[nx][ny] && grid[nx,ny] == cell
          stack.push([nx, ny])
        end
      end
    end

    components << [cell, component]
  end

  components
end

plant_plots = Hash.new { |hash, key| hash[key] = [] }

find_connected_components(grid).each do |cell_value, component|
  plant_plots[cell_value] << component
end

def count_fence_places(grid, plant, locations)
  count = 0
  locations.each do |location|
    homies = grid.get_homies(location[0], location[1])
    the_difference = locations.select { |loc| homies.include?(loc) }
    count += 4 - the_difference.size
  end
  count * locations.size
end

############
# Part One #
############

part_one = 0

plant_plots.each do |plant, plots|
  plots.each do |locations|
    part_one += count_fence_places(grid, plant, locations)
  end
end

puts "Part 1: #{part_one}"

############
# Part Two #
############

puts plant_plots.inspect

def im_so_over_this(grid, plant, locations)
  sides = {
    up: [],
    down: [],
    left: [],
    right: []
  }
  locations.each do |location|
    plot_above = [location[0] - 1, location[1]]
    plot_below = [location[0] + 1, location[1]]
    plot_left = [location[0], location[1] - 1]
    plot_right = [location[0], location[1] + 1]
    if !locations.include?(plot_above)
      sides[:up] << location
    end
    if !locations.include?(plot_below)
      sides[:down] << location
    end
    if !locations.include?(plot_left)
      sides[:left] << location
    end
    if !locations.include?(plot_right)
      sides[:right] << location
    end
  end
  count = 0
  left_edge_cols = sides[:left].map { |loc| loc[1] }.uniq
  right_edge_cols = sides[:right].map { |loc| loc[1] }.uniq
  top_edge_rows = sides[:up].map { |loc| loc[0] }.uniq
  bottom_edge_rows = sides[:down].map { |loc| loc[0] }.uniq
  count += left_edge_cols.size + right_edge_cols.size + top_edge_rows.size + bottom_edge_rows.size
  puts "Plant: #{plant}, areas: #{locations.size}, count: #{count}"
  count * locations.size
end

part_two = 0

plant_plots.each do |plant, locations|
  locations.each do |location|
    part_two += im_so_over_this(grid, plant, location)
  end
end

puts "Part 2: #{part_two}"
# def count_fence_places_with_sides(grid, plant, locations)
#   unique_sides = Set.new

#   locations.each do |x, y|
#     neighbors = grid.get_homies(x, y)

#     # Considering the 4 possible directions: up, down, left, right
#     [[x-1, y], [x+1, y], [x, y-1], [x, y+1]].each do |nx, ny|
#       if !neighbors.include?([nx, ny]) || grid[nx, ny] != plant
#         unique_sides.add([[x, y], [nx, ny]].sort)
#       end
#     end
#   end

#   return locations.size * unique_sides.size
# end

# part_two = 0

# plant_plots.each do |plant, plots|
#   plots.each do |locations|
#     part_two += count_fence_places_with_sides(grid, plant, locations)
#   end
# end

# puts "Part 2: #{part_two}"

